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
    var id: String = ""
    var email: String?
    var role: Role = .user
    var disabled: Bool = false
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
    }
    
    // Firebase User
    init(user: User) {
        self.email = user.email
        self.id = user.uid
    }
}
