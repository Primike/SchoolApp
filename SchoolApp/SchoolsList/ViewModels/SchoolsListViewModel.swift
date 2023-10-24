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
    func getSchool(indexPath: IndexPath) -> SchoolData
    func getSATData(indexPath: IndexPath) -> SATData
}

class SchoolsListViewModel: SchoolsListViewModeling {
    
    private let schoolsData: [SchoolData]
    private var searchResults: [SchoolData]
    
    init(schoolsData: [SchoolData]) {
        self.schoolsData = schoolsData
        self.searchResults = schoolsData
    }
    
    // MARK: - TableView Methods
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

            searchResults = schoolsData.filter { school in
                let text = school.school.mergedText ?? ""
                return text.lowercased().contains(search)
            }
        } else {
            searchResults = schoolsData
        }
    }

    func getSchool(indexPath: IndexPath) -> SchoolData {
        return searchResults[indexPath.row]
    }
    
    func getSATData(indexPath: IndexPath) -> SATData {
        return searchResults[indexPath.row].sat
    }
    
    //MARK: Cell Setup Methods
    func getSchoolName(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].school.school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].school.location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return searchResults[indexPath.row].school.boro.rawValue
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: searchResults[indexPath.row].school.boro)
    }
}

