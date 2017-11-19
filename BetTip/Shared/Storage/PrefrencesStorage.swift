//
//  PrefrencesStorage.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

protocol PrefrenceStorable {
}

class PrefrencesStorage {
    static let shared = PrefrencesStorage()
    
    private let defaults = UserDefaults(suiteName: "group.com.bettip")
    
    func remove(key: String) {
        self.defaults?.removeObject(forKey: key)
    }
    
    func store(_ value: PrefrenceStorable, key: String) {
        self.defaults?.set(value, forKey:key)
    }
    
    func restore<T>(key: String) -> T? where T: PrefrenceStorable {
        return self.defaults?.object(forKey: key) as! T?
    }
}

extension Int: PrefrenceStorable { }
extension String: PrefrenceStorable { }
extension Double: PrefrenceStorable { }
extension Float: PrefrenceStorable { }
extension Bool: PrefrenceStorable { }
