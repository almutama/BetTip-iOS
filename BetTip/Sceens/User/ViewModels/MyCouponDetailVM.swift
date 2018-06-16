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
    var couponDetail: Variable<[CouponModel]> { get set }
    func getUserCoupons(userId: String) -> Observable<[CouponModel]>
}

class MyCouponDetailVM: BaseViewModel, MyCouponDetailVMType {
    
    private let userService: UserServiceType!
    private let disposeBag = DisposeBag()
    var couponDetail: Variable<[CouponModel]> = Variable<[CouponModel]>([])
    
    init(userService: UserServiceType) {
        self.userService = userService
        super.init()
    }
    
    func getUserCoupons(userId: String) -> Observable<[CouponModel]> {
        return userService.userCoupons(userId: userId)
    }
}
