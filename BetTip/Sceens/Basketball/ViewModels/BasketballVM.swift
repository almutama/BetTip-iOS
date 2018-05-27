//
//  BasketballVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol BasketballVMType {
    func getBasketballMatches() -> Observable<[MatchModel]>
}

class BasketballVM: BaseViewModel, BasketballVMType {
    
    private let matchService: MatchServiceType!
    private let disposeBag = DisposeBag()
    
    init(matchService: MatchServiceType) {
        self.matchService = matchService
        super.init()
    }
    
    func getBasketballMatches() -> Observable<[MatchModel]> {
        return self.matchService.getMatches(matchType: Constants.basketballType, isSpecial: false)
    }
}
