//
//  MyCouponDetailVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol MyCouponDetailVMType {
    var coupon: Variable<CouponModel>? { get set }
    func getMatches() -> Observable<[MatchModel]>
    init(coupon: Variable<CouponModel>)
}

class MyCouponDetailVM: BaseViewModel, MyCouponDetailVMType {
    
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
