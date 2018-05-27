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
    func getProducts() -> Observable<[SKProduct]> 
}

class FootballVM: BaseViewModel, FootballVMType {
    
    private let matchService: MatchServiceType!
    private let disposeBag = DisposeBag()
    private let purchaseService: PurchaseServiceType!
    
    init(matchService: MatchServiceType, purchaseService: PurchaseServiceType) {
        self.matchService = matchService
        self.purchaseService = purchaseService
        super.init()
    }
    
    func getFootballMatches() -> Observable<[MatchModel]> {
        return self.matchService.getMatches(matchType: Constants.footballType, isSpecial: false)
    }
    
    func getProducts() -> Observable<[SKProduct]> {
        print("called")
        return self.purchaseService.getCachedProducts()
    }
}
