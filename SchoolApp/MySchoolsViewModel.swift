//
//  MySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewModel {
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School]) {
        self.schoolsSATData = schoolsSATData
        self.schoolsData = schoolsData
        mySchools()
    }
    
    func mySchools() {
        var x = [School]()
        
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        for i in savedArray {
            if let z = schoolsData.first(where: {$0.dbn == i}) {
                x.append(z)
            }
        }
        
        self.schoolsData = x
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        
        if schoolsData.count > 0 {
            let school = schoolsData[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
        } else {
            return (schoolName: "Loading", schoolAddress: "Loading", schoolBoro: "Loading")
        }
    }
    
    var schoolSATScores: SchoolScores?
    let scoresNotAvailable = SchoolScores(dbn: "0", num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                   sat_math_avg_score: "0",
                                   sat_writing_avg_score: "0")
    
    func rowSelectSearch(indexPath: IndexPath) {
        for data in schoolsSATData {
            if data.dbn == schoolsData[indexPath.row].dbn {
                schoolSATScores = data
                break
            }
        }
    }
    
    func getColor(school: School) -> UIColor {
        switch school.boro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.black
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}

