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
    var searchResults: [School] { get set }
    func getNumOfRowsInSection() -> Int
    func textChanged(searchText: String)
    func getSchool(indexPath: IndexPath) -> School
    func getSATData(indexPath: IndexPath) -> SATData
}

class SchoolsListViewModel: SchoolsListViewModeling, SchoolCellMethods {
    
    var schools = [School]()
    var satData = [SATData]()
    var searchResults = [School]()
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.satData = schoolsScores
        self.schools = schools
        self.searchResults = schools
    }
    
    //MARK: TableView Methods
    func getNumOfRowsInSection() -> Int {
        return searchResults.count
    }

    func textChanged(searchText: String) {
        if !searchText.isEmpty {
            let unwantedCharacters = Set(" ,.-():/")
            let search = searchText
                .replacingOccurrences(of: "&", with: "and")
                .filter { !unwantedCharacters.contains($0) }
                .lowercased()

            searchResults = schools.filter { school in
                return school.mergedText!.lowercased().contains(search)
            }
        } else {
            searchResults = schools
        }
    }

    func getSchool(indexPath: IndexPath) -> School {
        return searchResults[indexPath.row]
    }
    
    func getSATData(indexPath: IndexPath) -> SATData {
        return satData.first(where: {$0.dbn == searchResults[indexPath.row].dbn}) ?? SATData()
    }
    
    //MARK: Cell Setup Methods
    func getSchoolName(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].boro
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: searchResults[indexPath.row].boro)
    }
}

