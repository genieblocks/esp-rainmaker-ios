// Copyright 2020 Espressif Systems
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//  User.swift
//  ESPRainMaker
//

import Alamofire
import ESPProvision
import Foundation
import JWTDecode

class User {
    static let shared = User()
    var userInfo = UserInfo.getUserInfo()
    var accessToken: String?
    var associatedNodeList: [Node]?
    var username = ""
    var password = ""
    var automaticLogin = false
    var updateDeviceList = false
    var currentAssociationInfo: AssociationConfig?
    var updateUserInfo = false
    var localServices: [String: ESPLocalService] = [:]
    var discoveredNodes: [String] = []
    var discoveredNodesCompletion: (([String]) -> Void)?
    var matterLightOnStatus: [String: Bool] = [String: Bool]()

    lazy var localControl: ESPLocalControl = {
        ESPLocalControl()
    }()
    
    lazy var matterConnectionManager: ESPMatterConnectionManager = {
        ESPMatterConnectionManager()
    }()

    private init() {
        if let value = ESPTokenWorker.shared.accessTokenString {
            accessToken = value
        }
    }
    
    var isUserSessionActive: Bool {
        if let _ = ESPTokenWorker.shared.idTokenString {
            return true
        }
        return false
    }
    
    func updateUserInfo(token: String, provider: ServiceProvider) {
        do {
            let json = try decode(jwt: token)
            User.shared.userInfo.username = json.body["cognito:username"] as? String ?? ""
            User.shared.userInfo.email = json.body["email"] as? String ?? ""
            User.shared.userInfo.userID = json.body["custom:user_id"] as? String ?? ""
            User.shared.userInfo.loggedInWith = provider
            User.shared.userInfo.saveUserInfo()
        } catch {
            print("error parsing token")
        }
    }


    /// Method to configure and send association related information to the connected device
    ///
    /// - Parameters:
    ///   - session: Current established session with the device for sending information.
    ///   - delegate: Object that will recieve notification whether the info was delivered successfully
    func associateNodeWithUser(device: ESPDevice, delegate: DeviceAssociationProtocol) {
        currentAssociationInfo = AssociationConfig()
        currentAssociationInfo?.uuid = UUID().uuidString
        let deviceAssociation = DeviceAssociation(secretId: currentAssociationInfo!.uuid, device: device)
        deviceAssociation.associateDeviceWithUser()
        deviceAssociation.delegate = delegate
    }

    /// Update information of local network for existing nodes.
    ///
    private func updateNodeLocalNetworkInfo() {
        var notifyLocalNetworkUpdate = true
        if let nodeList = User.shared.associatedNodeList {
            let group = DispatchGroup()
            var localNodeList: [Node] = []
            for node in nodeList {
                if localServices.keys.contains(node.node_id ?? "") {
                    node.localNetwork = true
                    notifyLocalNetworkUpdate = false
                    setEncryptionOnLocalControl(node: node)
                    group.enter()
                    NetworkManager.shared.getNodeInfo(nodeId: node.node_id ?? "") { node, _ in
                        if node != nil {
                            localNodeList.append(node!)
                        }
                        group.leave()
                    }
                    
                } else {
                    node.localNetwork = false
                }
            }
            group.notify(queue: DispatchQueue.main) {
                self.processNodeInfoResponse(nodeList: localNodeList)
            }
        }
        if notifyLocalNetworkUpdate {
            NotificationCenter.default.post(Notification(name: Notification.Name(Constants.localNetworkUpdateNotification)))
        }
    }
    
    private func setEncryptionOnLocalControl(node: Node) {
        if let service = localServices[node.node_id ?? ""] {
            if node.supportsEncryption {
                service.espLocalDevice = ESPLocalDevice(name: "esp", security: .secure, transport: .softap, proofOfPossession: node.pop, softAPPassword: nil, advertisementData: nil)
                service.espLocalDevice.espSoftApTransport = ESPSoftAPTransport(baseUrl: service.hostname)
            }
            service.espLocalDevice.hostname = service.hostname
        }
    }

    private func processNodeInfoResponse(nodeList: [Node]) {
        for localNode in nodeList {
            if let index = User.shared.associatedNodeList?.firstIndex(where: { node -> Bool in
                node.node_id == localNode.node_id
            }) {
                localNode.localNetwork = true
                User.shared.associatedNodeList![index] = localNode
            }
        }
        if nodeList.count > 0 {
            NotificationCenter.default.post(Notification(name: Notification.Name(Constants.localNetworkUpdateNotification)))
        }
    }

    /// Start search for services on local network.
    ///
    func startServiceDiscovery() {
        DispatchQueue.main.async {
            self.localControl.delegate = self
            self.localControl.searchForServicesOfType(type: Constants.serviceType, domain: Constants.serviceDomain)
        }
    }
    
    /// Start search for matter devices on local network
    ///
    func startCommissionedMatterServiceDiscovery(discoveredNodesCompletion: @escaping ([String]) -> Void) {
        DispatchQueue.main.async {
            self.discoveredNodes.removeAll()
            self.discoveredNodesCompletion = discoveredNodesCompletion
            self.matterConnectionManager.delegate = self
            self.matterConnectionManager.searchForServicesOfType(type: Constants.matterCommissionedServiceType, domain: Constants.serviceDomain)
        }
    }
    
    /// Returns node from associated node list
    /// - Parameter id: node id
    /// - Returns: node for given node id or nil if it doesn't exist
    func getNode(id: String) -> Node? {
        let predicate = NSPredicate(format: "SELF == %@", id)
        let node = associatedNodeList?.first(where: {
            predicate.evaluate(with: ($0.node_id))
        })
        return node ?? nil
    }
    
    /// Is node connected over local netowkr
    /// - Parameter matterNodeId: matter node id
    /// - Returns: is connected
    func isMatterNodeConnected(matterNodeId: String) -> Bool {
        for id in User.shared.discoveredNodes {
            if id.uppercased().contains(matterNodeId.uppercased()) {
                return true
            }
        }
        return false
    }
}

extension User: ESPLocalControlDelegate {
    func updateInAvailableLocalServices(services: [ESPLocalService]) {
        localServices.removeAll()
        for service in services {
            var hostname = service.hostname
            if hostname.contains(".") {
                let endIndex = hostname.range(of: ".")!.lowerBound
                hostname = String(hostname[..<endIndex])
            }
            localServices[hostname] = service
        }
        updateNodeLocalNetworkInfo()
    }
}

extension User: ESPMatterNodesDiscoveredDelegate {
    func matterDevicesDiscovered(matterNodes: [String]) {
        self.matterConnectionManager.delegate = nil
        self.discoveredNodes = matterNodes
        self.discoveredNodesCompletion?(matterNodes)
    }
}
