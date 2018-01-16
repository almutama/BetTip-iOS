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
    var date: String?
    var time: String?
    var rate: Float?
    var matches: [MatchModel]?
}

extension CouponModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        numOfCredit <- map["numOfCredit"]
        date <- map["date"]
        time <- map["time"]
        rate <- map["rate"]
        matches <- map["matches"]
    }
}
