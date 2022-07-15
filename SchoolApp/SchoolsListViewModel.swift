//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit


class SchoolsListViewModel {
    
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    var schoolsSearchResults = [School]()
    
    var schoolSATScores: SchoolScores?
    let scoresNotAvailable = SchoolScores(dbn: "None", num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                   sat_math_avg_score: "0",
                                   sat_writing_avg_score: "0")
    
    
    init(schoolsData: [School], schoolsSATData: [SchoolScores]) {
        self.schoolsSATData = schoolsSATData
        self.schoolsData = schoolsData
        self.schoolsSearchResults = schoolsData
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        
        if schoolsSearchResults.count > 0 {
            let school = schoolsSearchResults[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
        } else {
            return (schoolName: "Loading", schoolAddress: "Loading", schoolBoro: "Loading")
        }
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
            schoolsData.filter { school in
                return school.mergedText!.lowercased().contains(search.lowercased())
            }
        } else {
            schoolsSearchResults = schoolsData
        }
    }
    
    func rowSelectSearch(indexPath: IndexPath) {
        for data in schoolsSATData {
            if data.dbn == schoolsSearchResults[indexPath.row].dbn {
                schoolSATScores = data
                break
            }
        }
    }
}

