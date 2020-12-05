//
//  InternetConnectionService.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/20.
//

import Foundation
import Network

class InternetConnectionService: NSObject {
    static let shared = InternetConnectionService()
    var isConnected = false
    var delegate: InternetConnectionServiceDelegate?
    
    func Start() {
        print("start of internet service")
        let networkQueue = DispatchQueue(label: "Network")
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                isConnected = true
                delegate?.Connected()
            } else {
                isConnected = false
                delegate?.Disconnected()
            }
        }
        
        monitor.start(queue: networkQueue)
    }
}

protocol InternetConnectionServiceDelegate {
    func Connected()
    func Disconnected()
}
