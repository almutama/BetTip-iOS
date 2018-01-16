//
//  ControlCouponsVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol ControlCouponsVMType {
    func getCoupons() -> Observable<[CouponModel]>
    func addCoupon(coupon: CouponModel, initComplete: @escaping (Bool?) -> Void)
    func updateCoupon(coupon: CouponModel) -> Observable<Bool>
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool>
}

class ControlCouponsVM: BaseViewModel, ControlCouponsVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        return adminService.getCoupons()
    }
    
    func addCoupon(coupon: CouponModel, initComplete: @escaping (Bool?) -> Void) {
        self.adminService
            .addCoupon(coupon: coupon)
            .trackActivity(loadingIndicator)
            .asObservable()
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "addCredit result: \(result)")
                    initComplete(true)
                case .error(let error):
                    logger.log(.error, "Error occured when adding credit: \(error)")
                case .completed:
                    logger.log(.debug, "Checking auth completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func updateCoupon(coupon: CouponModel) -> Observable<Bool> {
        return self.adminService
            .updateCoupon(coupon: coupon)
            .trackActivity(loadingIndicator)
            .asObservable()
            .map { credit in return (credit.value != nil) ? true : false }
            .catchErrorJustReturn(false)
    }
    
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool> {
        return self.adminService
            .deleteCoupon(coupon: coupon)
            .trackActivity(loadingIndicator)
            .asObservable()
    }
}
