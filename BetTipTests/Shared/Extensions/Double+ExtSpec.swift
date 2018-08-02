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
        describe("The rounded Double extension") {
            it("returns true double which is rounded with decimal numbers") {
                expect(23.123123.roundTo(places: 2)) == 23.12
            }
        }
    }
}
