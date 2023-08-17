// Copyright 2023 Espressif Systems
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
//  DeviceViewController+LaunchControllerDelegate.swift
//  ESPRainmaker
//

#if ESPRainMakerMatter
import Foundation
import UIKit

@available(iOS 16.4, *)
extension DeviceViewController: LaunchControllerDelegate {
    
    func launchController() {
        if let groupId = self.group?.groupID, let matterNodeId = self.matterNodeId, let deviceId = matterNodeId.hexToDecimal {
            DispatchQueue.main.async {
                Utility.showLoader(message: "", view: self.view)
            }
            ESPMTRCommissioner.shared.readAttributeUserNOCInstalled(deviceId: deviceId) { result in
                if result {
                    ESPMTRCommissioner.shared.updateDeviceList(deviceId: deviceId) { result in
                        DispatchQueue.main.async {
                            Utility.hideLoader(view: self.view)
                            if !result {
                                self.alertUser(title: ESPMatterConstants.failureTxt, message: ESPMatterConstants.operationFailedMsg, buttonTitle: ESPMatterConstants.okTxt, callback: {})
                            }
                        }
                    }
                    return
                }
                DispatchQueue.main.async {
                    Utility.hideLoader(view: self.view)
                    self.launchLoginScreen(groupId: groupId, matterNodeId: matterNodeId)
                }
            }
        }
    }
    
    func launchLoginScreen(groupId: String, matterNodeId: String) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let nav = storyboard.instantiateViewController(withIdentifier: "signInController") as? UINavigationController {
            if let signInVC = nav.viewControllers.first as? SignInViewController, let tab = self.tabBarController {
                signInVC.setRainmakerControllerProperties(isRainmakerControllerFlow: true,
                                                      groupId: groupId,
                                                      matterNodeId: matterNodeId,
                                                      rainmakerControllerDelegate: self)
                nav.modalPresentationStyle = .fullScreen
                tab.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    /// Append refresh token
    /// - Parameters:
    ///   - deviceId: device id
    ///   - refreshToken: refresh token
    ///   - completion: completion
    func appendRefreshToken(deviceId: UInt64, refreshToken: String, completion: @escaping (Bool) -> Void) {
        let index = refreshToken.index(refreshToken.startIndex, offsetBy: 960)
        let firstPayload = refreshToken[..<index]
        let secondPayload = refreshToken.replacingOccurrences(of: firstPayload, with: "")
        ESPMTRCommissioner.shared.appendRefreshToken(deviceId: deviceId, token: String(firstPayload)) { result in
            if result {
                ESPMTRCommissioner.shared.appendRefreshToken(deviceId: deviceId, token: secondPayload) { result in
                    completion(result)
                }
                return
            }
            completion(false)
        }
    }
    
    /// Authorize
    /// - Parameters:
    ///   - deviceId: device id
    ///   - endpointURL: endpoint URL
    ///   - completion: completion
    func authorize(matterNodeId: String, deviceId: UInt64, endpointURL: String) {
        ESPMTRCommissioner.shared.authorize(deviceId: deviceId, endpointURL: Configuration.shared.awsConfiguration.baseURL) { result in
            if result {
                ESPMTRCommissioner.shared.updateUserNOC(deviceId: deviceId) { result in
                    if result, let controller = ESPMTRCommissioner.shared.sController, let id = controller.controllerNodeID?.uint64Value {
                        ESPMTRCommissioner.shared.updateDeviceList(deviceId: id) { result in
                            if result {
                                DispatchQueue.main.async {
                                    Utility.hideLoader(view: self.view)
                                }
                                User.shared.updateDeviceList = true
                                let str = String(id, radix:16)
                                ESPMatterFabricDetails.shared.saveControllerNodeId(controllerNodeId: str, matterNodeId: matterNodeId)
                            } else {
                                DispatchQueue.main.async {
                                    self.hideLoaderAndShowError()
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoaderAndShowError()
                        }
                    }
                }
                return
            } else {
                DispatchQueue.main.async {
                    self.hideLoaderAndShowError()
                }
            }
        }
    }
}

@available(iOS 16.4, *)
extension DeviceViewController: RainmakerControllerFlowDelegate {
    
    func controllerFlowCancelled() {}
    
    func cloudLoginConcluded(cloudResponse: ESPSessionResponse?, groupId: String, matterNodeId: String) {
        if let cloudResponse = cloudResponse, cloudResponse.isValid, let refreshToken = cloudResponse.refreshToken {
            ESPMatterFabricDetails.shared.saveAWSTokens(cloudResponse: cloudResponse, groupId: groupId, matterNodeId: matterNodeId)
            if let deviceId = matterNodeId.hexToDecimal {
                DispatchQueue.main.async {
                    Utility.showLoader(message: "", view: self.view)
                }
                ESPMTRCommissioner.shared.resetRefreshToken(deviceId: deviceId) { result in
                    if result {
                        self.appendRefreshToken(deviceId: deviceId, refreshToken: refreshToken) { result in
                            if result {
                                self.authorize(matterNodeId: matterNodeId, deviceId: deviceId, endpointURL: Configuration.shared.awsConfiguration.baseURL)
                            } else {
                                DispatchQueue.main.async {
                                    self.hideLoaderAndShowError()
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoaderAndShowError()
                        }
                    }
                }
            }
        }
    }
    
    /// Hide loader and show error
    func hideLoaderAndShowError() {
        Utility.hideLoader(view: self.view)
        self.showErrorAlert(title: ESPMatterConstants.failureTxt, message: ESPMatterConstants.operationFailedMsg, buttonTitle: ESPMatterConstants.okTxt, callback: {})
    }
}
#endif