//
//  MyCouponsVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol MyCouponsVMType {
    func getCoupons() -> Observable<[CouponModel]>
}

class MyCouponsVM: BaseViewModel, MyCouponsVMType {
    
    private let userService: UserServiceType!
    private let disposeBag = DisposeBag()
    
    init(userService: UserServiceType) {
        self.userService = userService
        super.init()
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        guard let user =  UserEventService.shared.user.value else {
            return .just([])
        }
        return userService.userCoupons(userId: user.id)
    }
}
