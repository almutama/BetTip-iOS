//
//  ControlCreditsVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol ControlCreditsVMType {
    func getCredits() -> Observable<[CreditModel]>
    func addCredit(credit: CreditModel, initComplete: @escaping (Bool?) -> Void)
    func updateCredit(credit: CreditModel) -> Observable<Bool>
    func deleteCredit(credit: CreditModel) -> Observable<Bool>
}

class ControlCreditsVM: BaseViewModel, ControlCreditsVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return adminService.getCredits()
    }
    
    func addCredit(credit: CreditModel, initComplete: @escaping (Bool?) -> Void) {
        self.adminService
            .addCredit(credit: credit)
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
    
    func updateCredit(credit: CreditModel) -> Observable<Bool> {
        return self.adminService
            .updateCredit(credit: credit)
            .trackActivity(loadingIndicator)
            .asObservable()
            .map { credit in return (credit.value != nil) ? true : false }
            .catchErrorJustReturn(false)
    }
    
    func deleteCredit(credit: CreditModel) -> Observable<Bool> {
        return self.adminService
            .deleteCredit(credit: credit)
            .trackActivity(loadingIndicator)
            .asObservable()
    }
}
