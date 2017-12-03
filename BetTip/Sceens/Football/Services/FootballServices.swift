//
//  FootballServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Reactant
import Result

protocol FootballServiceType {
    func footballMatches() -> Observable<[FootballModel]>
}

class FootballService: FootballServiceType {
    
    func footballMatches() -> Observable<[FootballModel]> {
        let matches: Observable<[FootballModel]> = Database.database().reference()
            .child("Matches").queryOrdered(byChild: "Status").queryLimited(toLast: 50)
            .fetchArray()
            .recover([])
        return matches
    }
}
