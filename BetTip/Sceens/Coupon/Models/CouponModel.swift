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
    var price: Double?
    var date: String?
    var time: String?
    var rate: Float?
}

extension CouponModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        price <- map["price"]
        date <- map["date"]
        time <- map["time"]
        rate <- map["rate"]
    }
}
