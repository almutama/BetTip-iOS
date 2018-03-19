//
//  BasketballServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Reactant
import Result

protocol BasketballServiceType {
    func basketballMatches() -> Observable<[MatchModel]>
}

class BasketballService: BasketballServiceType {

    func basketballMatches() -> Observable<[MatchModel]> {
        let matches: Observable<[MatchModel]> = Database.database().reference()
            .child(Constants.matches)
            .queryOrdered(byChild: Constants.type)
            .queryEqual(toValue: Constants.basketballType)
            .queryLimited(toLast: Constants.queryLimit)
            .fetchArray()
            .recover([])
        return matches
    }
}
