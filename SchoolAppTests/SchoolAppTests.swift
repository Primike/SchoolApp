//
//  SchoolAppTests.swift
//  SchoolAppTests
//
//  Created by Prince Avecillas on 8/1/22.
//

import XCTest
@testable import SchoolApp

class SchoolAppTests: XCTestCase {
    
    var schooldata = [School]()

    override func setUpWithError() throws {
        do {
            if let bundlePath = Bundle.main.path(forResource: "SchoolsData",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let x = try! JSONDecoder().decode([School].self, from: jsonData)
                schooldata = x
            }
        } catch {
            print(error)
        }
    }

    override func tearDownWithError() throws {
    }

    func testJSONDecoder() {
        for i in 0..<schooldata.count {
            XCTAssertNotNil(schooldata[i].school_name)
            XCTAssertNotNil(schooldata[i].longitude)
            XCTAssertNotNil(schooldata[i].latitude)
            XCTAssertNotNil(schooldata[i].boro)
            XCTAssertNotNil(schooldata[i].dbn)
            XCTAssertNotNil(schooldata[i].overview_paragraph)
            XCTAssertNotNil(schooldata[i].interest1)
            XCTAssertNotNil(schooldata[i].phone_number)
            XCTAssertNotNil(schooldata[i].website)
            XCTAssertNotNil(schooldata[i].location)
        }
    }
    
    func testDuplicateLongitude() {
        var longitudeObject = [String: Int]()
        
        for i in schooldata {
            if longitudeObject[i.longitude ?? "0"] != nil {
                longitudeObject[i.longitude ?? "0"]! += 1
            } else {
                longitudeObject[i.longitude ?? "0"] = 1
            }
        }
        
        for i in longitudeObject {
            XCTAssert(i.value == 1)
        }
    }
}



