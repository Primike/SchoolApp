//
//  SchoolListViewModelTests.swift
//  SchoolAppTests
//
//  Created by Prince Avecillas on 8/4/22.
//

import XCTest
@testable import SchoolApp

class SchoolListViewModelTests: XCTestCase {
    
    var sut: SchoolsListViewModel!
    var schooldata = [School]()
    var satData = [SchoolScores]()
    
    override func setUpWithError() throws {
        do {
            if let bundlePath = Bundle.main.path(forResource: "SchoolsData",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let x = try! JSONDecoder().decode([School].self, from: jsonData)
                schooldata = x
            }
            
            if let bundlePath = Bundle.main.path(forResource: "SATData",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let y = try! JSONDecoder().decode([SchoolScores].self, from: jsonData)
                satData = y
            }
        } catch {
            print(error)
        }
        
        sut = SchoolsListViewModel(schools: schooldata, schoolsScores: satData)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    
}
