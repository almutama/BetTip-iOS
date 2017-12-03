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
    func getBasketballMatches() -> Observable<[BasketballModel]>
}

class BasketballVM: BaseViewModel, BasketballVMType {
    
    private let basketballService: BasketballServiceType!
    private let disposeBag = DisposeBag()
    
    init(basketballService: BasketballServiceType) {
        self.basketballService = basketballService
        super.init()
    }
    
    func getBasketballMatches() -> Observable<[BasketballModel]> {
        return self.basketballService.basketballMatches()
    }
}
