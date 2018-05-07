//
//  Rule.swift
//  BetTip
//
//  Created by Haydar Karkin on 7.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Result

public struct Rule<T, E: Error> {
    
    public let validate: (T) -> E?
    
    public init(validate: @escaping (T) -> E?) {
        self.validate = validate
    }
    
    public func test(_ value: T) -> Bool {
        return validate(value) == nil
    }
    
    public func run(_ value: T) -> Result<T, E> {
        if let error = validate(value) {
            return .failure(error)
        } else {
            return .success(value)
        }
    }
}
