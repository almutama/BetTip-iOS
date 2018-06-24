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
    
    init() {}
    
    init?(form: [String: Any?]? = nil) {
        guard let dic = form else { return }
        self.id = dic["id"] as? String ?? ""
        self.price = dic["price"] as? Double ?? 0
        self.numberOfCredits = dic["numberOfCredits"] as? Int ?? 0
    }
    
    init?(id: String, price: Double, numberOfCredits: Int) {
        self.id = id
        self.price = price
        self.numberOfCredits = numberOfCredits
    }
}

extension CreditModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        price <- map["price"]
        numberOfCredits <- map["numberOfCredits"]
    }
}
