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
    var schoolsScores = [SchoolScores]()
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School]) {
        self.schoolsScores = schoolsSATData
        self.schools = schoolsData
        mySchools()
    }
    
    func mySchools() {
        var mySchools = [School]()
        
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        for i in savedArray {
            if let school = schools.first(where: {$0.dbn == i}) {
                mySchools.append(school)
            }
        }
        
        self.schools = mySchools
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
            let school = schools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
}

