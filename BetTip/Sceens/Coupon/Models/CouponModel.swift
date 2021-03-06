//
//  CouponModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import ObjectMapper

struct CouponModel: BaseModel {
    var id: String?
    var numOfCredit: Int?
    var startDate: String?
    var startTime: String?
    var odd: Double?
    var won: Int?
    var tipster: String?
    var matches: [MatchModel]?
    var users: [String] = []
    
    init() {}
    
    init?(numOfCredit: Int,
         startDate: String,
         startTime: String,
         odd: Double,
         won: Int,
         tipster: String,
         matches: [MatchModel],
         users: [String] = []) {
        self.numOfCredit = numOfCredit
        self.startDate = startDate
        self.startTime = startTime
        self.odd = odd
        self.won = won
        self.tipster = tipster
        self.matches = matches
        self.users = users
    }
}

extension CouponModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        numOfCredit <- map["numOfCredit"]
        startDate <- map["start_date"]
        startTime <- map["start_time"]
        odd <- map["odd"]
        won <- map["won"]
        tipster <- map["tipster"]
        matches <- map["matches"]
        users <- map["users"]
    }
}

extension CouponModel {
    func isCouponExistForUser() -> Bool {
        if let user = UserEventService.shared.user.value {
            return self.users.contains(user.id)
        } else {
            return false
        }
    }
}
