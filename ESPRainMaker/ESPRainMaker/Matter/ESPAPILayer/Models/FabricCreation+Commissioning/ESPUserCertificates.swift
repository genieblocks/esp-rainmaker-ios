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
//  ESPUserCertificates.swift
//  ESPRainMaker
//

import Foundation

/// User NOC instance
struct ESPUserCertificates: Codable {
    
    var groupId: String?
    var matterNodeId: String?
    var userNOC: String?
    
    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case matterNodeId = "matter_user_id"
        case userNOC = "user_noc"
    }
    
    /// Get matter node id
    /// - Returns: matter node id
    func getMatterNodeId() -> String? {
        if let matterNodeId = self.matterNodeId,let id = ESPMatterFabricDetails.shared.getControllerNodeId(matterNodeId: matterNodeId) {
            if User.shared.isMatterNodeConnected(matterNodeId: id) {
                return id
            }
        }
        return matterNodeId
    }
}

