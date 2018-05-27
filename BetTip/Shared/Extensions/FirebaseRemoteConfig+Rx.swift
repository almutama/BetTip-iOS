//
//  FirebaseRemoteConfig+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import FirebaseRemoteConfig
import RxSwift

public extension RemoteConfig {
    /**
     Fetches Remote Config data and sets a duration that specifies how long config data lasts.
     
     @param expirationDuration  Duration that defines how long fetched config data is available, in seconds. When the config data expires, a new fetch is required.
     
     */
    func fetchWithExpirationDuration(expirationDuration: TimeInterval) -> Observable<RemoteConfig> {
        return Observable.create { observer in
            self.fetch(withExpirationDuration: expirationDuration) { (status, error) -> Void in
                if status == RemoteConfigFetchStatus.success {
                    self.activateFetched()
                    observer.onNext(self)
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
