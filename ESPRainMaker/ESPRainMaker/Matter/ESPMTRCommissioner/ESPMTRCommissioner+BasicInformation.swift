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
//  ESPMTRCommissioner+BasicInformation.swift
//  ESPRainmaker
//

#if ESPRainMakerMatter
import Foundation
import Matter

@available(iOS 16.4, *)
extension ESPMTRCommissioner {
    
    /// Get basic info cluster
    /// - Parameters:
    ///   - deviceId: device id
    ///   - completion: completion handler
    func getBasicInfomrationCluster(deviceId: UInt64, completion: @escaping (MTRBaseClusterBasicInformation?) -> Void) {
        if let controller = sController {
            if let device = try? controller.getDeviceBeingCommissioned(deviceId) {
                if let cluster = MTRBaseClusterBasicInformation(device: device, endpointID: NSNumber(value: 0), queue: ESPMTRCommissioner.shared.matterQueue) {
                    completion(cluster)
                } else {
                    completion(nil)
                }
            } else {
                controller.getBaseDevice(deviceId, queue: ESPMTRCommissioner.shared.matterQueue) { device, _ in
                    if let device = device, let cluster = MTRBaseClusterBasicInformation(device: device, endpointID: NSNumber(value: 0), queue: ESPMTRCommissioner.shared.matterQueue) {
                        completion(cluster)
                    } else {
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func getVendorId(deviceId: UInt64, completion: @escaping (Int?) -> Void) {
        self.getBasicInfomrationCluster(deviceId: deviceId) { cluster in
            if let cluster = cluster {
                cluster.readAttributeVendorID { vid, _ in
                    if let vid = vid {
                        completion(vid.intValue)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getProductId(deviceId: UInt64, completion: @escaping (Int?) -> Void) {
        self.getBasicInfomrationCluster(deviceId: deviceId) { cluster in
            if let cluster = cluster {
                cluster.readAttributeProductID { pid, _ in
                    if let pid = pid {
                        completion(pid.intValue)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getSoftwareVersion(deviceId: UInt64, completion: @escaping (Int?) -> Void) {
        self.getBasicInfomrationCluster(deviceId: deviceId) { cluster in
            if let cluster = cluster {
                cluster.readAttributeSoftwareVersion { swv, _ in
                    if let swv = swv {
                        completion(swv.intValue)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
}
#endif