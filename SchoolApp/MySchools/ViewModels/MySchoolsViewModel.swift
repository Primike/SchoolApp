//
//  MySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

protocol MySchoolsViewModeling {
    var schoolsData: [SchoolData] { get }
    func mySchools()
}

class MySchoolsViewModel: MySchoolsViewModeling, SchoolCellMethods {
    
    var schoolsData: [SchoolData]
    
    init(schoolsData: [SchoolData]) {
        self.schoolsData = schoolsData
        mySchools()
    }
    
    func mySchools() {
        var mySchools = [SchoolData]()
        
        let savedArray = UserDefaults.standard.object(forKey: "array") as? [String] ?? [String]()

        for id in savedArray {
            if let school = schoolsData.first(where: { $0.school.dbn == id }) {
                mySchools.append(school)
            }
        }
        
        self.schoolsData = SchoolDataModifier.modifyCoordinateDuplicates(nearbySchools: mySchools)
    }
    
    //MARK: Cell Methods    
    func getSchoolName(indexPath: IndexPath) -> String {
        return schoolsData[indexPath.row].school.school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return schoolsData[indexPath.row].school.location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return schoolsData[indexPath.row].school.boro.rawValue
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: schoolsData[indexPath.row].school.boro)
    }
}
