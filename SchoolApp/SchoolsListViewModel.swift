//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

protocol SchoolsListViewModeling {
    var schools: [School] { get set }
    var satData: [SATData] { get set }
    var schoolSearchResults: [School] { get set }
    var schoolScores: SATData { get set }
    func getNumOfRowsInSection() -> Int?
    func textChanged(searchText: String)
    func rowSelectSearch(indexPath: IndexPath)
}

class SchoolsListViewModel: SchoolsListViewModeling, SchoolCellMethods {
    
    var schools = [School]()
    var satData = [SATData]()
    var schoolSearchResults = [School]()
    var schoolScores = SATData()
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.satData = schoolsScores
        self.schools = schools
        self.schoolSearchResults = schools
    }
    
    //MARK: TableView Methods
    func getNumOfRowsInSection() -> Int? {
        return schoolSearchResults.count
    }

    func textChanged(searchText: String) {
        var search = searchText
        
        if searchText != "" {
            let array = [" ", ",", ".", "-", "(", ")", ":", "/"]
            for i in array {
                search = search.replacingOccurrences(of: i, with: "")
            }
            search = search.replacingOccurrences(of: "&", with: "and")

            schoolSearchResults =
            schools.filter { school in
                return school.mergedText!.lowercased().contains(search.lowercased())
            }
        } else {
            schoolSearchResults = schools
        }
    }
    
    func rowSelectSearch(indexPath: IndexPath) {
        if let scores = satData.first(where: {$0.dbn == schoolSearchResults[indexPath.row].dbn}) {
            schoolScores = scores
        } else {
            schoolScores = SATData()
        }
    }
    
    //MARK: Cell Methods
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        let school = schoolSearchResults[indexPath.row]
        return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
    
    func getSchoolName(indexPath: IndexPath) -> String {
        return schoolSearchResults[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return schoolSearchResults[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return schoolSearchResults[indexPath.row].boro
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: schoolSearchResults[indexPath.row].boro)
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

