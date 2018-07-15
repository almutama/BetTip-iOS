//
//  ControlMatchesVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol ControlMatchesVMType {
    var matches: Variable<[MatchModel]> { get set }
    func getMatchesWithType(type: MatchAction)
}

class ControlMatchesVM: BaseViewModel, ControlMatchesVMType {
    
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
                    self.matches.value = result.filter { $0.status == 1 }
                case .error(let error):
                    logger.log(.error, "Error occured when getting \(type): \(error)")
                case .completed:
                    logger.log(.debug, "getting matches for \(type) completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getMatches(type: MatchAction) -> Observable<[MatchModel]> {
        return adminService.getMatches(type: type.rawValue)
    }
}
