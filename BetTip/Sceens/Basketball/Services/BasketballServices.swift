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
    func basketballMatches() -> Observable<[BasketballModel]>
}

class BasketballService: BasketballServiceType {

    func basketballMatches() -> Observable<[BasketballModel]> {
        let matches: Observable<[BasketballModel]> = Database.database().reference()
            .child("Matches").queryOrdered(byChild: "Status").queryLimited(toLast: 50)
            .fetchArray()
            .recover([])
        return matches
    }
}
