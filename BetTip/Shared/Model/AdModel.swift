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
    var imgURL: URL?
    var adURL: URL?
    
    init() {}
    
    init?(form: [String: Any?]? = nil) {
        guard let dic = form else { return }
        self.imgURL = dic["imgURL"] as? URL ?? URL.init(string: "")
        self.adURL = dic["adURL"] as? URL ?? URL.init(string: "")
    }
}

extension AdModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        imgURL <- (map["imgURL"], URLTransform())
        adURL <- (map["adURL"], URLTransform())
    }
}
