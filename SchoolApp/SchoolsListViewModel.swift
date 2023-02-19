//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class SchoolsListViewModel {
    
    var schools = [School]()
    var schoolsScores = [SATScores]()
    var schoolSearchResults = [School]()
    
    var schoolScores = SATScores()
    
    init(schools: [School], schoolsScores: [SATScores]) {
        self.schoolsScores = schoolsScores
        self.schools = schools
        self.schoolSearchResults = schools
    }
    
    func getNumOfRowsInSection() -> Int? {
        return schoolSearchResults.count
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        let school = schoolSearchResults[indexPath.row]
        return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
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
        if let scores = schoolsScores.first(where: {$0.dbn == schoolSearchResults[indexPath.row].dbn}) {
            schoolScores = scores
        } else {
            schoolScores = SATScores()
        }
    }
}

