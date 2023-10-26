//
//  SchoolViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import CoreLocation
import UIKit

class SchoolViewModel: SchoolColor {
    var schoolData: SchoolData
    
    init(schoolData: SchoolData) {
        self.schoolData = schoolData
    }
    
    var coordinates: CLLocationCoordinate2D? {
        return schoolData.school.coordinates
    }
    
    var websiteURL: URL? {
        return URL(string: "https://\(schoolData.school.website)")
    }
    
    func getAddSchoolButtonImageName() -> String {
        let savedSchools = UserDefaults.standard.object(forKey: "array") as? [String] ?? [String]()

        return savedSchools.contains(schoolData.school.dbn) ? "checkmark" : "plus.circle"
    }
    
    func addOrRemoveSchool() -> (String, Bool) {
        var savedSchools = UserDefaults.standard.object(forKey: "array") as? [String] ?? [String]()
        var willShowAlert = true
        
        if savedSchools.contains(schoolData.school.dbn) {
            UserDefaults.standard.set(savedSchools.filter { $0 != schoolData.school.dbn }, forKey: "array")
            willShowAlert = false
        } else {
            savedSchools.append(schoolData.school.dbn)
            UserDefaults.standard.set(savedSchools, forKey: "array")
        }
        
        return (getAddSchoolButtonImageName(), willShowAlert)
    }
}
