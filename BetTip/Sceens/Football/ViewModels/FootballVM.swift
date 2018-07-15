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
    func shouldAdsShow() -> Bool
    func adsWasShown()
}

class FootballVM: BaseViewModel, FootballVMType {
    
    private let matchService: MatchServiceType!
    private var userVariableProvider: UserVariableProviderType!
    private let disposeBag = DisposeBag()
    
    init(matchService: MatchServiceType,
         userVariableProvider: UserVariableProviderType) {
        self.userVariableProvider = userVariableProvider
        self.matchService = matchService
        super.init()
    }
    
    func getFootballMatches() -> Observable<[MatchModel]> {
        return self.matchService.getMatches(matchType: Constants.footballType).map({matches in
            return matches.filter({ match in
                guard let isSpecial = match.isSpecial else {
                    return true
                }
                return isSpecial == false
            })
        })
    }
    
    func shouldAdsShow() -> Bool {
        return self.userVariableProvider.shownAdsNumber % Constants.showAdsPerOpen == 0
    }
    
    func adsWasShown() {
        self.userVariableProvider.shownAdsNumber += 1
    }
}
