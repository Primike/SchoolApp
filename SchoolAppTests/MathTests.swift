//
//  MathTests.swift
//  SchoolAppTests
//
//  Created by Prince Avecillas on 8/1/22.
//

import XCTest
@testable import SchoolApp

class MathTests: XCTestCase {

    var sut: Math!

    override func setUpWithError() throws {
        sut = Math()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testMathSum() {
        let x = 1
        let y = 2
        
        let result = sut.add(x: x, y: y)
        
        XCTAssertEqual(result, 3)
    }

}



