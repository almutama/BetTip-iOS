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
    func getMatches(type: Int) -> Observable<[MatchModel]>
}

class ControlMatchesVM: BaseViewModel, ControlMatchesVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getMatches(type: Int) -> Observable<[MatchModel]> {
        return adminService.getMatches(type: type)
    }
}
