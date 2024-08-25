//
//  Date.swift
//  Sporty
//
//  Created by marwa maky on 25/08/2024.
//



import Foundation
import Alamofire


extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
    static let networkUnavailable = Notification.Name("networkUnavailable")
}

class Connectivity {
    static let shared = Connectivity()
    
    private init() {
        startNetworkMonitoring()
    }
    
    private(set) var isReachable: Bool = true
    
    private func startNetworkMonitoring() {
        NetworkReachabilityManager()?.startListening { [weak self] status in
            self?.handleNetworkStatusChange(status)
        }
    }
    
    private func handleNetworkStatusChange(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        let reachable = (status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular))
        isReachable = reachable
        NotificationCenter.default.post(name: .networkStatusChanged, object: nil, userInfo: ["isReachable": reachable])
    }
}
