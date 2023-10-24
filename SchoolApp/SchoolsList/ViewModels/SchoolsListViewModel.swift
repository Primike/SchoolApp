//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

protocol SchoolsListViewModeling: SchoolCellMethods {
    var isSorted: Bool { get set }
    func getNumOfRowsInSection() -> Int
    func textChanged(searchText: String)
    func getSchool(indexPath: IndexPath) -> SchoolData
}

class SchoolsListViewModel: SchoolsListViewModeling {
    
    private let schoolsData: [SchoolData]
    private var searchResults: [SchoolData]
    var isSorted = false
    
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
        
        if isSorted {
            searchResults = searchResults.sorted { $0.sat.totalScore > $1.sat.totalScore }
        }
    }

    func getSchool(indexPath: IndexPath) -> SchoolData {
        return searchResults[indexPath.row]
    }
                
    // MARK: - Cell Setup Methods
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
