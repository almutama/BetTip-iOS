//
//  Date+ExtSpec.swift
//  BetTipTests
//
//  Created by Haydar Karkin on 3.08.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Quick
import Nimble
@testable import BetTip

class DateExtensionTests: QuickSpec {
    override func spec() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2016/10/08 22:31")
        
        describe("Date extension") {
            it("should return calender components for given date") {
                expect(someDateTime?.day).to(equal(08))
                expect(someDateTime?.month).to(equal(10))
                expect(someDateTime?.year).to(equal(2016))
            }
            
            describe("dateWithFormat function") {
                it("should returns true format for given date format") {
                    expect(someDateTime?.dateWithFormat(dateFormat: "dd-MM-yyyy HH.mm")).to(equal("08-10-2016 22.31"))
                }
                
                it("should returns true format for standart date format") {
                    expect(someDateTime?.dateWithFormat()).to(equal("08:10:2016 22:31"))
                }
            }
            
            describe("monthInt function") {
                it("should returns month as integer") {
                    expect(someDateTime?.monthInt()).to(equal(10))
                }
            }
            
            describe("fromUTC function") {
                it("should returns date as UTC format") {
                    expect(Date.fromUTC(format: "2016-10-08T19:31:00.000")).to(equal(someDateTime))
                }
            }
            
            describe("toUTC function") {
                it("should returns string as UTC format") {
                    expect(Date.toUTC(from: someDateTime!)).to(equal("2016-10-08T19:31:00.000"))
                }
            }
        }
        
        describe("TimeInterval extension") {
            it("should returns true values for time interval") {
                expect(TimeInterval.second).to(equal(1))
                expect(TimeInterval.minute).to(equal(60))
                expect(TimeInterval.hour).to(equal(3600))
                expect(TimeInterval.day).to(equal(86400))
                expect(TimeInterval.week).to(equal(604800))
                expect(TimeInterval.month).to(equal(2592000))
                expect(TimeInterval.year).to(equal(31536000))
            }
        }
    }
}
