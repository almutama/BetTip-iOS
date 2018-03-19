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
    
    private let footballService: FootballServiceType!
    private let disposeBag = DisposeBag()
    
    init(footballService: FootballServiceType) {
        self.footballService = footballService
        super.init()
    }
    
    func getFootballMatches() -> Observable<[MatchModel]> {
        return self.footballService.footballMatches()
    }
}
