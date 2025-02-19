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
//  ESPMatterConstants.swift
//  ESPRainmaker
//

import Foundation

struct ESPMatterConstants {
    
    /// Utils
    static let controller = "controller"
    static let acceptedSharings = "acceptedSharings"
    static let pendingNodeGroupRequests = "pendingNodeGroupRequests"
    static let requestsSent = "requestsSent"
    static let sharingsAcceptedBy = "sharingsAcceptedBy"
    static let vendorId = "vendorId"
    static let productId = "productId"
    static let softwareVersion = "softwareVersion"
    static let warning = "Warning"
    static let info = "Info"
    static let matterPrefix = "MT:"
    static let matterStoryboardId = "ESPMatter"
    static let lightDevice = "light"
    static let switchDevice = "switch"
    static let defaultDevice = "default"
    static let controllerNodeId = "controllerNodeId"
    
    /// UI keys
    static let bindings = "bindings"
    static let home = "Home"
    static let matter = "Matter"
    static let switchTxt = "Switch"
    static let dismissTxt = "Dismiss"
    static let deviceTxt = "Device"
    static let backTxt = "Back"
    static let doneTxt = "Done"
    static let okTxt = "OK"
    static let yesTxt = "Yes"
    static let noTxt = "No"
    static let failureTxt = "Failure"
    static let retryTxt = "Retry"
    static let errorTxt = "Error"
    static let cancelTxt = "Cancel"
    static let successTxt = "Success"
    static let logoutTxt = "Logout"
    static let confirmTxt = "Confirm"
    static let updateTxt = "Update"
    static let removeTxt = "Remove"
    static let rmDeviceTxt = "Remove device"
    static let emailIdTxt = "Email ID"
    static let shareTxt = "Share"
    static let devicesTxt = "Devices"
    static let createGroupTxt = "Create Group"
    static let updateGroupTxt = "Update Group"
    static let deviceBindingTxt = "Device Binding"
    static let createTxt = "Create"
    static let shareGroupTxt = "Share Group"
    static let sendRequestTxt = "Send Request"
    static let cancelRequestTxt = "Cancel Request"
    static let revokeRequestTxt = "Revoke Request"
    static let enterGroupNameTxt = "Enter group name"
    static let enterGroupNameRequestTxt = "Please enter a group name"
    static let requestsReceivedTxt = "Requests received"
    static let groupSharingTxt = "Group Sharing"
    static let addGroupTxt = "Add Group"
    static let selectGroupTxt = "Select Group"
    static let name = "name"
    static let onOff = "onOff"
    static let levelControl = "levelControl"
    static let colorControl = "colorControl"
    static let binding = "binding"
    static let openCW = "openCW"
    static let rainmakerController = "rainmakerController"
    static let delete = "delete"
    static let share = "share"
    static let add = "add"
    static let yes = "YES"
    static let no = "NO"
    static let email = "E-mail"
    static let edit = "Edit"
    static let linking = "Linking"
    static let ipk = "ipk"
    static let revoke = "Revoke"
    static let deviceName = "deviceName"
    static let isRainmaker = "isRainmaker"
    static let serversData = "serversData"
    static let clientsData = "clientsData"
    static let endpointsData = "endpointsData"
    static let deviceType = "deviceType"
    static let linkedDevices = "LINKED DEVICES"
    static let unlinkedDevices = "AVAILABLE DEVICES"
    static let deviceLinks = "Device Links"
    static let navigationController = "NavigationViewController"
    
    /// API keys
    static let id = "id"
    static let amazonRootCAFileName = "amazonRootCA"
    static let trueFlag = "true"
    static let falseFlag = "false"
    static let failure = "failure"
    static let success = "success"
    static let remove = "remove"
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let applicationURLEncoded = "application/x-www-form-urlencoded"
    static let authorization = "Authorization"
    static let node = "node"
    static let user = "user"
    static let userName = "user_name"
    static let password = "password"
    static let newPassword = "newpassword"
    static let verificationCode = "verification_code"
    static let refreshToken = "refreshtoken"
    static let grantType = "grant_type"
    static let authorizationCode = "authorization_code"
    static let code = "code"
    static let redirctURI = "redirect_uri"
    static let clientId = "client_id"
    static let groupName = "group_name"
    static let type = "type"
    static let structure = "Structure"
    static let contextTag = "contextTag"
    static let mutuallyExclusive = "mutually_exclusive"
    static let description = "description"
    static let isMatter = "is_matter"
    static let nodes = "nodes"
    static let operation = "operation"
    static let csr = "csr"
    static let csrType = "csr_type"
    static let csrRequests = "csr_requests"
    static let requestId = "request_id"
    static let status = "status"
    static let groups = "groups"
    static let primary = "primary"
    static let metadata = "metadata"
    static let groupMetadata = "group_metadata"
    static let devices = "devices"
    static let accept = "accept"
    static let tags = "tags"
    static let deviceNameTag = "esp.device.name"
    static let rainmakerNodeId = "rainmaker_node_id"
    static let challenge = "challenge"
    static let requestStatus = "request_status"
    static let groupIds = "group_ids"
    static let nodeDetails = "node_details"
    static let userId = "user_id"
    static let nodeId = "node_id"
    static let secretKey = "secret_key"
    static let pending = "pending"
    static let groupId = "group_id"
    static let addIcon = "add_icon"
    static let onTxt = "On"
    static let offTxt = "Off"
    static let espressif = "Espressif"
    
    
    /// Messages
    static let operationFailedMsg = "Operation failed"
    static let mtrPairingFailedMsg = "Failed to pair device."
    static let sharingGroupMsg = "Sharing group..."
    static let groupShareSuccessMsg = "Group sharing request sent successfully."
    static let groupShareFailedMsg = "Failed to share group."
    static let scanQRCodeMsg = "Since you are trying to commission a matter device, you will have to scan the QR code again using the scanner that will appear next."
    static let shareNodeMsg = "Share Node"
    static let copyCodeMsg = "Copy code"
    static let fetchingGroupsDataMsg = "Fetching groups data..."
    static let updatingNodeGroupMsg = "Fetching groups data..."
    static let commissioningFailedMsg = "Commissioning failed."
    static let commissioningFailureMsg = "Failed to commission device."
    static let challengeFailedMsg = "Challenge failed."
    static let fetchChallengeFailedMsg = "Failed to get challenge from device."
    static let checkingMatterConnMsg = "Checking matter connection"
    static let fetchingDevicesDataMsg = "Fetching devices data...."
    static let fetchingRainmakerDataMsg = "Fetching Rainmaker data..."
    static let fetchingEndpointsMsg = "Fetching endpoints..."
    static let removingDeviceMsg = "Removing device..."
    static let groupDeletionSuccessMsg = "Group deleted successfully"
    static let openCWFailureMsg = "Failed to open commissioning window. Please try later!"
    static let linkingDevicesMeg = "Linking devices..."
    static let unlinkingDevicesMsg = "Unlinking devices..."
    static let removeDeviceMsg = "Are you sure you want to remove this device?"
    static let shareGroupEmailMessage = "Enter email id of user to share the device with"
    static let matterRainmakerDevices = "matter.rainmaker.devices"
    static let pairingModeTitle = "Accessory Ready to Connect"
    static let fetchBindingMsg = "Fetching node binding details..."
    static let unbindingFailureMsg = "Failed to unbind devices."
    static let bindingFailureMsg = "Failed to bind devices."
    static let paramUpdateFailureMsg = "Fail to update parameter. Please check you network connection!!"
    static let shareGroupMsg = "Enter username of user with whom you want to share the group."
    static let cancelRequestMsg = "Are you sure you want to cancel this request?"
    static let revokeRequestMsg = "Are you sure you want revoke access to this group?"
    static let removeGroupSharingMsg = "Are you sure you want to remove this group?"
    static let cancelRequestFailedMsg = "Failed to cancel request."
    static let revokeRequestFailedMsg = "Failed to cancel request."
    static let cancellingRequestMsg = "Cancelling request..."
    static let revokingRequestMsg = "Cancelling request..."
    static let pairingModeMessage = "\"Matter Accessory\" is now in pairing mode. Use the setup code to connect.\n\n Setup Code: 35174439122"
    static let upgradeOSVersionMsg = "You must upgrade to iOS 16.4 or above in order to commission matter nodes."
    static let failedToRemoveDeviceMsg: String = "Failed to remove device."
    static let matterNotSupportedMsg = "App does not support Matter."
    static let fetchSharingRequestsMsg = "Fetching node sharing requests..."
    static let emptyString: String = ""
    static let chipDeviceId: String = "ChipDeviceId"
    static let fetchingDeviceDetailsMsg: String = "Fetching device details..."
    static let updatingDeviceDetailsMsg: String = "Updating device details..."
    static let updatingDeviceListMsg: String = "Updating device list..."
    static let controllerNeedsAccessMsg: String = "Matter Controller needs access to your RainMaker account to fetch all nodes under the account. Proceed?"
    /// Matter data keys
    static let groupIdKey = "group.com.espressif.rainmaker.softap"
    static let homesDataKey: String = "com.espressif.hmmatterdemo.homes"
    static let roomsDataKey: String = "com.espressif.hmmatterdemo.rooms"
    static let matterDevicesKey: String = "com.espressif.hmmatterdemo.devices"
    static let matterDevicesName: String = "com.espressif.hmmatterdemo.deviceName"
    static let matterStepsKey: String = "com.espressif.hmmatterdemo.step"
    static let matterUUIDKey: String = "com.espressif.hmmatterdemo.commissionerUUID"
    static let onboardingPayloadKey: String = "com.espressif.hmmatterdemo.onboardingPayload"
    static let commissioningSB: String = "ESPCommissioning"
    
    /// Create new home keys
    static let createNewHomeTitle: String = "Create new Home?"
    static let createNewHomeMsg: String = "Enter the name of your new home and give it a Room"
    static let removeDeviceMessage: String = "Would you like to remove this device?"
    static let updateNodeGroupMsg: String = "Do you want to update node group to matter fabric?"
    
    /// color hexcodes
    static let customBackgroundColor: String = "#005493"
    
    
    static let onOffClusterId: UInt = 6
    static let levelControlClusterId: UInt = 8
    static let colorControlClusterId: UInt = 768
    static let commissioningWindowClusterId: UInt = 60
    static let bindingClusterId: UInt = 30
    static let controllerClusterId: UInt = 320601089
    
    static let csrHeader = "-----BEGIN CERTIFICATE REQUEST-----"
    static let csrFooter = "-----END CERTIFICATE REQUEST-----"
    
    static let UTF8String = "UTF8String"
    static let data = "data"
    static let value = "value"
}
