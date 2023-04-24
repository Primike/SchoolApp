//
//  Reachability.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/5/22.
//

import Foundation
import Network

class Reachability {
    
    private static let monitor = NWPathMonitor()
    
    static var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    static func startMonitoring() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    static func stopMonitoring() {
        monitor.cancel()
    }
}
