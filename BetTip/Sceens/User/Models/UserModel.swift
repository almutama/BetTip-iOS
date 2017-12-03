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

struct UserModel {
    var id: String = ""
    var email: String?
    var role: Role = .user
    var disabled: Bool = false
    
    // Firebase User
    init(user: User) {
        self.email = user.email
        self.id = user.uid
    }
}

extension UserModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        role <- map["role"]
        disabled <- map["disabled"]
    }
}
