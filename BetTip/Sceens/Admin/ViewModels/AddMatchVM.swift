//
//  AddMatchVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 31.03.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol AddMatchVMType {
    func addMatch(match: MatchModel, initComplete: @escaping (Bool?) -> Void)
}

class AddMatchVM: BaseViewModel, AddMatchVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func addMatch(match: MatchModel, initComplete: @escaping (Bool?) -> Void) {
        self.adminService
            .addMatch(match: match)
            .trackActivity(loadingIndicator)
            .asObservable()
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "adding match result: \(result)")
                    initComplete(true)
                case .error(let error):
                    logger.log(.error, "Error occured when adding match: \(error)")
                    initComplete(false)
                case .completed:
                    logger.log(.debug, "Adding match completed!")
                }
            }
            .disposed(by: disposeBag)
    }
}
