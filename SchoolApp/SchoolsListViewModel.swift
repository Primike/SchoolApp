//
//  SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit


class SchoolsListViewModel {
    weak var delegate: RequestDelegate?
    var state: ViewState {
        didSet {
//            print("Updated with \(state)")
            self.delegate?.didUpdate(with: state)
        }
    }
    
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    var schoolsSearchResults = [School]()
    
    init() {
        self.state = .idle
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
    //move 
    func getColor(school: School) -> UIColor {
        switch school.boro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.black
        case "Q":
            return UIColor.systemPurple 
        default:
            return .systemGreen
        }
    }
    
    var schoolSATScores: SchoolScores?
    let scoresNotAvailable = SchoolScores(dbn: "0", num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                   sat_math_avg_score: "0",
                                   sat_writing_avg_score: "0")
    
    func rowSelectSearch(indexPath: IndexPath) {
        for data in schoolsSATData {
            if data.dbn == schoolsSearchResults[indexPath.row].dbn {
                schoolSATScores = data
                break
            }
        }
    }
}

extension SchoolsListViewModel {
    func loadData() {
        self.state = .loading
        SchoolServiceAPI.shared.getSchoolsData { result in
            switch result {
            case .success(let schools):
                self.schoolsData = schools
                self.schoolsSearchResults = self.schoolsData
//                self.completedAPIFetches += 1
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
                print(error.localizedDescription)
            }
        }
        
        SchoolServiceAPI.shared.getTestData { result in
            switch result {
            case .success(let scores):
                self.schoolsSATData = scores
                self.state = .success
//                self.completedAPIFetches += 1
            case .failure(let error):
                self.state = .error(error)
                print(error.localizedDescription)
            }
        }
    }
}
