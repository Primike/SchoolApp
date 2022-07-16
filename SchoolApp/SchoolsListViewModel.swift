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
    var schoolsScores = [SchoolScores]()
    var schoolsSearchResults = [School]()
    
    var schoolScores: SchoolScores?
    let scoresNotAvailable = SchoolScores(dbn: "None", num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                   sat_math_avg_score: "0",
                                   sat_writing_avg_score: "0")
    
    
    init(schools: [School], schoolsScores: [SchoolScores]) {
        self.schoolsScores = schoolsScores
        self.schools = schools
        self.schoolsSearchResults = schools
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        let school = schoolsSearchResults[indexPath.row]
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

            schoolsSearchResults =
            schools.filter { school in
                return school.mergedText!.lowercased().contains(search.lowercased())
            }
        } else {
            schoolsSearchResults = schools
        }
    }
    
    func rowSelectSearch(indexPath: IndexPath) {
        if let scores = schoolsScores.first(where: {$0.dbn == schoolsSearchResults[indexPath.row].dbn}) {
            schoolScores = scores
        }
    }
}

