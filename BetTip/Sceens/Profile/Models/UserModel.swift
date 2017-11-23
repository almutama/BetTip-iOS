//
//  UserModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import ObjectMapper
import Firebase

struct UserModel: Mappable {
    var id: String?
    var name: String?
    var surName: String?
    var email: String?
    var token: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- (map["id"], TransformOf(fromJSON: { (intVal: Int?) -> String? in
            return String(describing: NSNumber(value: intVal ?? 0))
        }, toJSON: { (stringVal: String?) -> Int? in
            return Int(stringVal!)
        }))
        
        name <- map["name"]
        surName <- map["surname"]
        email <- map["email"]
        token <- map["token"]
    }
    
    // Firebase User
    init(user: User) {
        self.email = user.email
        self.name = user.displayName
        self.id = user.uid
    }
    
    func fullName() -> String {
        var str = self.name ?? nil
        if self.surName != nil {
            str = str == nil ? self.surName : "\(str!) \(surName!)"
        }
        return str ?? ""
    }
    
    func getUserID() -> Int {
        return Int(self.id!)!
    }
}
