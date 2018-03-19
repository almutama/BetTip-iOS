//
//  ReachabilityManager.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Reachability

protocol ReachabilityManagerType: class {
    var currentReachabilityStatus: Reachability.Connection { get }
}

enum ReachabilityManagerError: Error {
    case unreachable
}

final class ReachabilityManager: ReachabilityManagerType {
    fileprivate var reachability: Reachability?
    fileprivate let fallbackNetworkStatus = Reachability.Connection.none
    
    fileprivate init(reachability: Reachability) {
        self.reachability = reachability
    }
    
    init() {
        do {
            if let reachability = Reachability() {
                self.reachability = reachability
                reachability.whenReachable = whenReachable
                reachability.whenUnreachable = whenUnreachable
                try self.reachability!.startNotifier()
            }
        } catch { }
    }
    
    var currentReachabilityStatus: Reachability.Connection {
        return reachability?.connection ?? fallbackNetworkStatus
    }
    
    fileprivate func whenReachable(_ reachability: Reachability) {
    }
    
    fileprivate func whenUnreachable(_ reachability: Reachability) {
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}
