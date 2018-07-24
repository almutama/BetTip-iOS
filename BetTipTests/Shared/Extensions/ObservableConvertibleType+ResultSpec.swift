//
//  ObservableConvertibleType+ResultSpec.swift
//  BetTipTests
//
//  Created by Haydar Karkin on 24.07.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import Result
import RxOptional
@testable import BetTip

class ObservableConvertibleType_ResultSpec: QuickSpec {
    
    override func spec() {
        describe("ObservableConvertibleType+Result") {
            let data = [Result.success(0), Result.failure(ErrorStub.unknown)]
            var called = 0
            var disposeBag = DisposeBag()
            beforeEach {
                called = 0
                disposeBag = DisposeBag()
            }
            
            describe("filterError") {
                it("returns only values") {
                    Observable.from(data)
                        .filterError()
                        .subscribe(onNext: { value in
                            called += 1
                            
                            expect(value) == 0
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 1
                }
            }
            describe("errorOnly") {
                it("returns only errors") {
                    Observable.from(data)
                        .errorOnly()
                        .subscribe(onNext: { error in
                            called += 1
                            
                            expect(error) == ErrorStub.unknown
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 1
                }
            }
            describe("mapValue") {
                it("returns mapped value") {
                    Observable.from(data)
                        .mapValue { "\($0)" }
                        .subscribe(onNext: { result in
                            switch result {
                            case .success(let value):
                                called += 1
                                expect(value) == "0"
                            case .failure(let error):
                                called += 2
                                expect(error) == ErrorStub.unknown
                            }
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 3
                }
            }
            describe("mapError") {
                it("returns mapped error") {
                    Observable.from(data)
                        .mapError { _ in AnotherErrorStub.custom }
                        .subscribe(onNext: { result in
                            switch result {
                            case .success(let value):
                                called += 1
                                expect(value) == 0
                            case .failure(let error):
                                called += 2
                                expect(error) == AnotherErrorStub.custom
                            }
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 3
                }
            }
            describe("rewriteValue") {
                it("replaces value with newValue") {
                    Observable.from(data)
                        .rewriteValue(newValue: "A")
                        .subscribe(onNext: { result in
                            switch result {
                            case .success(let value):
                                called += 1
                                expect(value) == "A"
                            case .failure(let error):
                                called += 2
                                expect(error) == ErrorStub.unknown
                            }
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 3
                }
            }
            describe("recover") {
                it("returns value or argument on error") {
                    Observable.from(data)
                        .recover(1)
                        .subscribe(onNext: { value in
                            if value == 0 {
                                called += 1
                            } else if value == 1 {
                                called += 2
                            } else {
                                fail()
                            }
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 3
                }
            }
            describe("recoverWithNil") {
                it("returns value or nil") {
                    Observable.from(data)
                        .recoverWithNil()
                        .subscribe(onNext: { value in
                            if let value = value, value == 0 {
                                called += 1
                            } else if value == nil {
                                called += 2
                            } else {
                                fail()
                            }
                        }).disposed(by: disposeBag)
                    
                    expect(called) == 3
                }
            }
        }
    }
    
    private enum ErrorStub: Error {
        case unknown
    }
    
    private enum AnotherErrorStub: Error {
        case custom
    }
}
