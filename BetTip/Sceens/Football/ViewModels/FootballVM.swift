//
//  FootballVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol FootballVMType {
    func getFootballMatches() -> Observable<[MatchModel]>
}

class FootballVM: BaseViewModel, FootballVMType {
    
    private let matchService: MatchServiceType!
    private let disposeBag = DisposeBag()
    
    init(matchService: MatchServiceType) {
        self.matchService = matchService
        super.init()
    }
    
    func getFootballMatches() -> Observable<[MatchModel]> {
        return self.matchService.getMatches(matchType: Constants.footballType, isSpecial: false)
    }
}
