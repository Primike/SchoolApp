//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

protocol SchoolsListViewModeling: SchoolCellMethods {
    func getNumOfRowsInSection() -> Int
    func textChanged(searchText: String)
    func getSchool(indexPath: IndexPath) -> School
    func getSATData(indexPath: IndexPath) -> SATData
}

class SchoolsListViewModel: SchoolsListViewModeling {
    
    private let schools: [School]
    private let satData: [SATData]
    private var searchResults: [School]
    
    init(schools: [School], satData: [SATData]) {
        self.satData = satData
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
        return searchResults[indexPath.row].boro.rawValue
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: searchResults[indexPath.row].boro)
    }
}

