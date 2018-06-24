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
    var tipster: String?
    var isSpecial: Bool?
    
    init() {}
    
    init?(form: [String: Any?]? = nil) {
        guard let dic = form else { return }
        let date = dic["date"] as? Date ?? Date()
        let time = dic["time"] as? Date ?? Date()
        
        self.type = dic["type"] as? Int ?? 0
        self.country = dic["country"] as? String ?? ""
        self.league = dic["league"] as? String ?? ""
        self.homeTeam = dic["homeTeam"] as? String ?? ""
        self.awayTeam = dic["awayTeam"] as? String ?? ""
        self.date = date.dateWithFormat(dateFormat: "dd.MM.yyyy")
        self.time = time.dateWithFormat(dateFormat: "HH:mm")
        self.bet = dic["bet"] as? String ?? ""
        self.odd = dic["odd"] as? Double ?? 0.0
        self.won = dic["won"] as? Int ?? 0
        self.status = dic["status"] as? Int ?? 0
        self.iddaaId = dic["iddaaId"] as? Int ?? 0
        self.site = dic["site"] as? String ?? ""
        self.tipster = dic["tipster"] as? String ?? ""
        self.isSpecial = dic["isSpecial"] as? Bool ?? false
    }
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
        tipster <- map["tipster"]
        isSpecial <- map["isSpecial"]
    }
}

func === (lhs: MatchModel, rhs: MatchModel) -> Bool {
    if let iddaaIdL = lhs.iddaaId,
        let iddaaIdR = lhs.iddaaId,
        let oddL = lhs.odd,
        let oddR = rhs.odd {
        return iddaaIdL == iddaaIdR && oddL == oddR
    }
    return false
}

func !== (lhs: MatchModel, rhs: MatchModel) -> Bool {
    if let iddaaIdL = lhs.iddaaId,
        let iddaaIdR = lhs.iddaaId,
        let oddL = lhs.odd,
        let oddR = rhs.odd {
        return iddaaIdL != iddaaIdR && oddL != oddR
    }
    return false
}

func << (lhs: MatchModel, rhs: MatchModel) -> Bool {
    guard let lStatus = lhs.status,
        let rStatus = rhs.status else {
        return false
    }
    return lStatus < rStatus
}
