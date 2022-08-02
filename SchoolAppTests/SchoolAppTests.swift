//
//  SchoolAppTests.swift
//  SchoolAppTests
//
//  Created by Prince Avecillas on 8/1/22.
//

import XCTest
@testable import SchoolApp

class SchoolAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONDecoder() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "SchoolsData",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let x = try! JSONDecoder().decode([School].self, from: jsonData)
                
                for i in 0..<x.count {
                    XCTAssertNotNil(x[i].school_name)
                    XCTAssertNotNil(x[i].longitude)
                }
            }
        } catch {
            print(error)
        }

    }
    
    func testCanParseLocalData() {
        guard let pathString = Bundle.main.path(forResource: "SchoolsData", ofType: "json") else {
            fatalError("JSON not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
    }
}



