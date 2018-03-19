//
//  Array+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.03.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    @discardableResult mutating func delete(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func delete(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
}
