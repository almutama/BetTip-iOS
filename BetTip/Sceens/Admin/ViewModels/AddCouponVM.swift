//
//  AddCouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol AddCouponVMType {
    func getMatches() -> Observable<[MatchModel]>
    func addCoupon(coupon: CouponModel, initComplete: @escaping (Bool?) -> Void)
}

class AddCouponVM: BaseViewModel, AddCouponVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getMatches() -> Observable<[MatchModel]> {
        return adminService.basketballMatches()
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
}
