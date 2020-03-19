//
//  AssessmentTests.swift
//  AssessmentTests
//
//  Created by VishalP on 17/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import XCTest
@testable import Assessment

class AssessmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testDateFormats()
        testStringToDate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDateFormats(){
        let strDate = "2020-02-10"
        let result = Util.convertDateFormat(stringDate: strDate, givenFormat: "yyyy-MM-dd", expectedFormat: "dd-MM-yyyy")
        //let expectation = self.expectation(description: "10-02-2020")
        XCTAssertEqual(result, "10-02-2020")
    }
    
    func testStringToDate(){
        let dtStr = "2019-09-15" //Test formats yyyy-MMM-dd
        let result = Util.convertStringToDate(stringDate: dtStr, givenFormat: "yyyy-MM-dd")
        XCTAssertNotNil(result)
    }
    
    func testSortAndGroupArray(){
        let sta1 = Statement(balance: 10.0, credit: 5.0, debit: 2.0, stmtId: "stamt-01", stamtDate: "2020-02-15")
        let sta2 = Statement(balance: 10.0, credit: 5.0, debit: 2.0, stmtId: "stamt-01", stamtDate: "2014-06-15")
        let sta3 = Statement(balance: 10.0, credit: 5.0, debit: 2.0, stmtId: "stamt-01", stamtDate: "2016-05-10")
        let sta4 = Statement(balance: 10.0, credit: 5.0, debit: 2.0, stmtId: "stamt-01", stamtDate: "2014-02-20")
        let sta5 = Statement(balance: 10.0, credit: 5.0, debit: 2.0, stmtId: "stamt-01", stamtDate: "2020-01-05")
        
        let arr = [sta1, sta5, sta3, sta4, sta2]
        var result = Util.sortAndGroupDateByYear(dateArray: arr)
        
        let arrCount = "3"
        
        let expect = self.expectation(description: arrCount)
        
        XCTAssertNotNil(result)
        
        let strResCount = "\(result.count)"
        if strResCount == arrCount{
            expect.fulfill()
        }else{
            XCTFail("Failed with data not sorted and valid")
        }
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testGetDataFromUrl() {
        NetworkService.sharedService.dataFromURLPath(fileName: BaseFileName) { (res: AllStatement?, err: Error?) in
            
            if let error = err{
                XCTFail("Failed to get Data:\(error.localizedDescription)")
            }
            
            if let result = res{
                XCTAssertNotNil(result)
            }else{
                XCTFail()
            }
        }
    }

}
