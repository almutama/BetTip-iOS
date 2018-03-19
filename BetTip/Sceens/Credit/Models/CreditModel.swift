//
//  CouponModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import ObjectMapper

struct CreditModel: BaseModel {
    var id: String?
    var price: Double?
    var numberOfCredits: Int?
}

extension CreditModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        price <- map["price"]
        numberOfCredits <- map["numberOfCredits"]
    }
}
