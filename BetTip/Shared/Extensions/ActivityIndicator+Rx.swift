//
//  ActivityIndicator+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ActivityTracker: SharedSequenceConvertibleType {
    typealias E = Bool
    typealias SharingStrategy = DriverSharingStrategy
    
    private let _lock = NSRecursiveLock()
    private let _variable = Variable(false)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    
    init() {
        _loading = _variable.asDriver()
            .distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        _lock.lock()
        _variable.value = true
        _lock.unlock()
    }
    
    private func sendStopLoading() {
        _lock.lock()
        _variable.value = false
        _lock.unlock()
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
        return _loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityTracker: ActivityTracker) -> Observable<E> {
        return activityTracker.trackActivityOfObservable(self)
    }
}
