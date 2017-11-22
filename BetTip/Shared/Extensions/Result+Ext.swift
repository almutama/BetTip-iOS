//
//  Result+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 22.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

import Foundation

public enum ResultError<T>: Error {
    case illegalCombination(T?, Error?)
}

enum Result<T> {
    case success(T)
    case failure(Error)
    
    init(_ value: T?, _ error: Error?) {
        switch (value, error) {
        case (let value?, nil):
            self = .success(value)
        case (nil, let error?):
            self = .failure(error)
        default:
            self = .failure(ResultError.illegalCombination(value, error))
        }
    }
}
