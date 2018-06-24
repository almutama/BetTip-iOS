//
//  CouponDetailVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol CouponDetailVMType {
    var coupon: Variable<CouponModel>? { get set }
    func getMatches() -> Observable<[MatchModel]>
    init(coupon: Variable<CouponModel>)
}

class CouponDetailVM: BaseViewModel, CouponDetailVMType {
    
    var coupon: Variable<CouponModel>?
    
    required init(coupon: Variable<CouponModel>) {
        self.coupon = coupon
        super.init()
    }
    
    func getMatches() -> Observable<[MatchModel]> {
        guard let matches = self.coupon?.value.matches else {
            return Observable.just([])
        }
        return Observable.just(matches)
    }
}
