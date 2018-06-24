//
//  UserCreditModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 4.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import ObjectMapper
import Firebase

enum UserCreditAction {
    case append
    case subtrack
}

struct UserCreditModel: BaseModel {
    var id: String?
    var currentCredit: Int?
    var usedCredit: Int?
    
    init(id: String, currentCredit: Int, usedCredit: Int) {
        self.id = id
        self.currentCredit = currentCredit
        self.usedCredit = usedCredit
    }
}

extension UserCreditModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        currentCredit <- map["currentCredit"]
        usedCredit <- map["usedCredit"]
    }
}
