//
//  UserEventService.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class UserEventService: PubSubSubscriberProtocol, EventBusObservable {
    static let shared = UserEventService()
    internal var eventBusObserver = EventBusObserver()
    
    lazy private(set) var user: Variable<UserModel?> = {
        return Variable<UserModel?>(self.restoreUser())
    }()
    
    func registerForEvents() {
        self.handleBGEvent {[weak self] (event: BGDidLoginEvent) in
            self?.user.value = event.user
        }
    }
    
    private func restoreUser() -> UserModel? {
        return nil
    }
}
