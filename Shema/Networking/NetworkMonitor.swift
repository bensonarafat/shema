//
//  NetworkMonitor.swift
//  Shema
//
//  Created by Benson Arafat on 04/01/2026.
//

import Foundation
import Network
import Combine


class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.shema.networkmonitor")
    
    @Published var isConnected: Bool = true
    @Published var connectionType: ConnectionType = .unknown
    @Published var isExpensive: Bool = false
    
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
        
        var description: String {
            switch self {
            case .wifi: return "Wi-fi"
            case .cellular: return "Cellular"
            case .ethernet: return "Ethernet"
            case .unknown: return "Unknown"
            }
        }
    }
    
    private init () {
        startMonitoring()
    }
    
    func startMonitoring () {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.isExpensive = path.isExpensive
                self?.getConnectionType(path)
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring () {
        monitor.cancel()
    }
    
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else  if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    deinit {
        stopMonitoring()
    }
}

extension NetworkMonitor {
    // Check if device is connected via Wifi
    var isConnectedViaWifi: Bool {
        return isConnected && connectionType == .wifi
    }
    
    // Check if device is connected via Cellular
    var isConnectedViaCellular: Bool {
        return isConnected && connectionType == .cellular
    }
    
    // Check if connection is available and not expensive (useful for large downloads)
    var isConnectedAndNotExpensive: Bool {
        return isConnected && !isExpensive
    }
}
