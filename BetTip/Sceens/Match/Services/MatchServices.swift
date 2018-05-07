//
//  MatchServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 8.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Result

protocol MatchServiceType {
    func getMatches(matchType: Int) -> Observable<[MatchModel]>
    func addMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>>
    func updateMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>>
    func deleteMatch(match: MatchModel) -> Observable<Bool>
}

class MatchService: MatchServiceType {    
    
    func getMatches(matchType: Int) -> Observable<[MatchModel]> {
        let matches: Observable<[MatchModel]> = Database.database().reference()
            .child(Constants.matches)
            .queryOrdered(byChild: Constants.type)
            .queryEqual(toValue: matchType)
            .queryLimited(toLast: Constants.queryLimit)
            .fetchArray()
            .recover([])
        return matches
    }
    
    func addMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.matches)
            .storeObject(match)
    }
    
    func updateMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.matches)
            .update(match)
    }
    
    func deleteMatch(match: MatchModel) -> Observable<Bool> {
        return Database.database().reference()
            .child(Constants.matches)
            .deleteWithoutFailure(match)
    }
}
