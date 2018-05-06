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
    var odd: Double?
    var won: Int?
    var tipster: String?
    var matches: [MatchModel]?
    
//    init(numOfCredit: Int,
//         startDate: String,
//         odd: Double,
//         won: Int,
//         tipster: String,
//         matches: [MatchModel]) {
//        self.numOfCredit = numOfCredit
//        self.startDate = startDate
//        self.odd = odd
//        self.won = won
//        self.tipster = tipster
//        self.matches = matches
//    }
}

extension CouponModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        numOfCredit <- map["numOfCredit"]
        startDate <- map["start_date"]
        odd <- map["odd"]
        won <- map["won"]
        tipster <- map["tipster"]
        matches <- map["matches"]
    }
}
