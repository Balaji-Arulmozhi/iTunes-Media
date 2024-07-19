//
//  NetworkManager.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/19/24.
//

import Foundation
import Network

class NetworkManager{
    var isConnect: Bool?
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private var queue = DispatchQueue.global()
    
    func isConnected(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnect =  path.status == .satisfied
            print("\(String(describing: self?.isConnect))")
        }
        
    }
}
