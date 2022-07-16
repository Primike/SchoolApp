//
//  Top10SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

struct Top10SchoolsListViewModel {
    
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School]) {
        self.schoolsScores = schoolsSATData
        self.schools = schoolsData
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
            let school = schools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
    
}
