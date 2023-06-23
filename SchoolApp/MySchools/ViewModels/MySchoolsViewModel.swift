//
//  MySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

protocol MySchoolsViewModeling {
    var schools: [School] { get set }
    var schoolsScores: [SATData] { get set }
    func mySchools()
}

class MySchoolsViewModel: MySchoolsViewModeling, SchoolCellMethods {
    
    var schools = [School]()
    var schoolsScores = [SATData]()
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
        mySchools()
    }
    
    func mySchools() {
        var mySchools = [School]()
        var mySchoolsScores = [SATData]()
        
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
                mySchoolsScores.append(SATData())
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
    
    //MARK: Cell Methods    
    func getSchoolName(indexPath: IndexPath) -> String {
        return schools[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return schools[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return schools[indexPath.row].boro.rawValue
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: schools[indexPath.row].boro)
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

