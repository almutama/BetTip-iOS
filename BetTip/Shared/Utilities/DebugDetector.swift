//
//  DebugDetector.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

struct DebugDetector {
    static func debuggerAttached() -> Bool {
        #if DEBUG
            var info = kinfo_proc()
            var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
            var size = MemoryLayout.stride(ofValue: info)
            let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
            assert(junk == 0, "sysctl failed")
            return (info.kp_proc.p_flag & P_TRACED) != 0
        #else
            return false
        #endif
    }
}

@objc class DebugStates: NSObject {
    private static var _subscription = false
    
    static func setSubscription(_ enabled: Bool) {
        _subscription = enabled
    }
    
    static func subscription() -> Bool {
        return isDebug && _subscription
    }
    
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
