//
//  AdModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper

struct AdModel: BaseModel {
    var id: String?
    var imgURL: Int?
    var adURL: String?
    
    init() {}
    
    init?(form: [String: Any?]? = nil) {
        guard let dic = form else { return }
        self.imgURL = dic["imgURL"] as? Int ?? 0
        self.adURL = dic["adURL"] as? String ?? ""
    }
}

extension AdModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        imgURL <- map["imgURL"]
        adURL <- map["adURL"]
    }
}
