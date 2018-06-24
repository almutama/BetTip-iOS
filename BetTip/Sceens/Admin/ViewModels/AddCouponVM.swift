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
    var matches: Variable<[MatchModel]> { get set }
    func getMatchesWithType(type: MatchAction)
    func addCoupon(coupon: CouponModel, initComplete: @escaping (Bool?) -> Void)
}

class AddCouponVM: BaseViewModel, AddCouponVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    var matches: Variable<[MatchModel]> = Variable<[MatchModel]>([])
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getMatchesWithType(type: MatchAction) {
        self.getMatches(type: type)
            .trackActivity(loadingIndicator)
            .asObservable()
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "get matches for \(type)'s result: \(result)")
                    self.matches.value = result.filter { $0.isSpecial == true }
                case .error(let error):
                    logger.log(.error, "Error occured when getting \(type): \(error)")
                case .completed:
                    logger.log(.debug, "getting matches for \(type) completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getMatches(type: MatchAction) -> Observable<[MatchModel]> {
        print("get match type: \(type.rawValue)")
        return adminService.getMatches(type: type.rawValue, isSpecial: true)
    }
    
    func addCoupon(coupon: CouponModel, initComplete: @escaping (Bool?) -> Void) {
        self.adminService
            .addCoupon(coupon: coupon)
            .trackActivity(loadingIndicator)
            .asObservable()
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "adding coupon result: \(result)")
                    initComplete(true)
                case .error(let error):
                    logger.log(.error, "Error occured when adding coupon: \(error)")
                case .completed:
                    logger.log(.debug, "Adding coupon completed!")
                }
            }
            .disposed(by: disposeBag)
    }
}
