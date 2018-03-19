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

struct UserCreditModel: BaseModel {
    var id: String?
    var currentCredit: Int?
    var usedCredit: Int?
    
    init(currentCredit: Int, usedCredit: Int) {
        self.currentCredit = currentCredit
        self.usedCredit = usedCredit
    }
}

extension UserCreditModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        currentCredit <- map["currentCredit"]
        usedCredit <- map["usedCredit"]
    }
}
