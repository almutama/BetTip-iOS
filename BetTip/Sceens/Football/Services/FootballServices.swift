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
    func footballMatches() -> Observable<[MatchModel]>
}

class FootballService: FootballServiceType {
    
    func footballMatches() -> Observable<[MatchModel]> {
        let matches: Observable<[MatchModel]> = Database.database().reference()
            .child(Constants.matches).queryOrdered(byChild: Constants.status).queryLimited(toLast: 50)
            .fetchArray()
            .recover([])
        return matches
    }
}
