//
//  MySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewModel {
    
    var schools = [School]()
    var schoolsScores = [SATScores]()
    
    init(schools: [School], schoolsScores: [SATScores]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
        mySchools()
    }
    
    func mySchools() {
        var mySchools = [School]()
        var mySchoolsScores = [SATScores]()
        
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        for i in savedArray {
            if let school = schools.first(where: {$0.dbn == i}) {
                mySchools.append(school)
            }
        }
        
        for i in mySchools {
            if let scores = schoolsScores.first(where: {$0.dbn == i.dbn}) {
                mySchoolsScores.append(scores)
            } else {
                mySchoolsScores.append(SATScores())
            }
        }
        self.schools = mySchools
        self.schoolsScores = mySchoolsScores
        
        for i in 0..<schools.count {
            for j in 0..<schools.count {
                if i != j && schools[i].latitude == schools[j].latitude && schools[i].longitude == schools[j].longitude {
                    schools[j].longitude = "\(Double(schools[j].longitude!)! + 0.0007 - 0.00009*Double(j))"
                }
            }
        }
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
            let school = schools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
}

