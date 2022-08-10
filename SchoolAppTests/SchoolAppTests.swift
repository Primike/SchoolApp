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

//    func testJSONDecoder() {
//        for i in 304..<305{
//            print(schooldata[i].school_name)
//            XCTAssertNotNil(schooldata[i].school_name)
//            XCTAssertNotNil(schooldata[i].longitude)
//            XCTAssertNotNil(schooldata[i].latitude)
//            XCTAssertNotNil(schooldata[i].boro)
//            XCTAssertNotNil(schooldata[i].dbn)
//            XCTAssertNotNil(schooldata[i].overview_paragraph)
//            XCTAssertNotNil(schooldata[i].phone_number)
//            XCTAssertNotNil(schooldata[i].website)
//            XCTAssertNotNil(schooldata[i].location)
//        }
//    }
    
//    func testDuplicateLongitude() {
//        var longitudeObject = [String: Int]()
//
//        for i in schooldata {
//            if longitudeObject[i.longitude ?? "\(i.dbn)"] != nil {
//                longitudeObject[i.longitude ?? "\(i.dbn)"]! += 1
//            } else {
//                longitudeObject[i.longitude ?? "\(i.dbn)"] = 1
//            }
//        }
//
//        for i in longitudeObject {
//            XCTAssert(i.value <= 5)
//        }
//    }
//
//    func testDuplicateLatitude() {
//        var latitudeObject = [String: Int]()
//
//        for i in schooldata {
//            if latitudeObject[i.latitude ?? "\(i.dbn)"] != nil {
//                latitudeObject[i.latitude ?? "\(i.dbn)"]! += 1
//            } else {
//                latitudeObject[i.latitude ?? "\(i.dbn)"] = 1
//            }
//        }
//
//        for i in latitudeObject {
//            XCTAssert(i.value <= 5)
//        }
//    }
    
//    func testDuplicateCoordinates() {
//        var object = [String: Int]()
//        
//        for i in schooldata {
//            if object["\(i.latitude)\(i.longitude)" ?? "\(i.dbn)"] != nil {
//                object["\(i.latitude)\(i.longitude)" ?? "\(i.dbn)"]! += 1
//            } else {
//                object["\(i.latitude)\(i.longitude)" ?? "\(i.dbn)"] = 1
//            }
//        }
//        
//        for i in object {
//            XCTAssert(i.value <= 4)
//        }
//    }
    
    
//    func testFirstSchool() {
//        XCTAssertNotNil(schooldata[0].latitude)
//        XCTAssertNotNil(schooldata[0].longitude)
//        XCTAssertNotNil(schooldata[0].distance)
//
//    }
}



