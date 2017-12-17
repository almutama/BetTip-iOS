//
//  BasketballModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import ObjectMapper

struct MatchModel: BaseModel {
    var id: String?
    var type: Int?
    var country: String?
    var league: String?
    var homeTeam: String?
    var awayTeam: String?
    var date: String?
    var time: String?
    var bet: String?
    var odd: Double?
    var won: Int?
    var status: Int?
    var iddaaId: Int?
    var site: String?
}

extension MatchModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        country <- map["country"]
        league <- map["league"]
        homeTeam <- map["homeTeam"]
        awayTeam <- map["awayTeam"]
        date <- map["date"]
        time <- map["time"]
        bet <- map["bet"]
        odd <- map["odd"]
        won <- map["won"]
        status <- map["status"]
        iddaaId <- map["iddaaId"]
        site <- map["site"]
    }
}
