//
//  MySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

protocol MySchoolsViewModeling {
    var schoolsData: [SchoolData] { get set }
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
        
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        for id in savedArray {
            if let school = schoolsData.first(where: { $0.school.dbn == id }) {
                mySchools.append(school)
            }
        }
        
        self.schoolsData = mySchools
        
        for i in 0..<schoolsData.count {
            for j in 0..<schoolsData.count {
                if i != j && schoolsData[i].school.latitude == schoolsData[j].school.latitude && schoolsData[i].school.longitude == schoolsData[j].school.longitude {
                    schoolsData[j].school.longitude = "\(Double(schoolsData[j].school.longitude!)! + 0.0007 - 0.00009*Double(j))"
                }
            }
        }
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

    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.systemRed
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}

