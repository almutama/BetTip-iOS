//
//  Double+ExtSpec.swift
//  BetTipTests
//
//  Created by Haydar Karkin on 1.08.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Quick
import Nimble
@testable import BetTip

class DoubleExtensionTests: QuickSpec {
    override func spec() {
        describe("Double extension") {
            it("should returns true double which is rounded with 2 decimal numbers") {
                expect(23.123123.roundTo(places: 2)).to(equal(23.12))
            }
            it("should returns true double which is rounded with 3 decimal numbers") {
                expect(23.123123.roundTo(places: 3)).to(equal(23.123))
            }
            it("should returns false double which is rounded with 2 decimal numbers") {
                expect(23.123123.roundTo(places: 2)).toNot(equal(23.123))
            }
            it("should returns true double which is rounded with 0 decimal numbers") {
                expect(23.123123.roundTo(places: 0)).to(equal(23))
            }
            it("should returns true double which is rounded with 2 decimal numbers") {
                expect(23.198.roundTo(places: 2)).to(equal(23.20))
            }
        }
    }
}
