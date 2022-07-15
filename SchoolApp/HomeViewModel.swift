//
//  HomeViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation

class HomeViewModel {
    
    weak var delegate: RequestDelegate?
    var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    init() {
        self.state = .idle
    }
    
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    var top10SchoolsScores = [SchoolScores]()
    var top10Schools = [School]()
    
    //fix incase schools come first maybe call getschooldata in gettestdata .success
    func loadData() {
        self.state = .loading
        SchoolServiceAPI.shared.getSchoolsData { result in
            switch result {
            case .success(let schools):
                self.schoolsData = schools
                self.getTopSchools()
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
                self.getTopSchoolsScores()
                
            case .failure(let error):
                self.state = .error(error)
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewModel {
    func getTopSchoolsScores() {
                
        for i in 0..<schoolsSATData.count {
            if Int(schoolsSATData[i].sat_critical_reading_avg_score) != nil && Int(schoolsSATData[i].sat_math_avg_score) != nil && Int(schoolsSATData[i].sat_writing_avg_score) != nil {
            } else {
                schoolsSATData[i] = SchoolScores(dbn: schoolsSATData[i].dbn, num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                      sat_math_avg_score: "0",
                                      sat_writing_avg_score: "0")
            }
        }
        let sortedSATData = schoolsSATData.sorted(by: { Int($0.sat_critical_reading_avg_score)! + Int($0.sat_math_avg_score)! + Int($0.sat_writing_avg_score)! > Int($1.sat_critical_reading_avg_score)! + Int($1.sat_math_avg_score)! + Int($1.sat_writing_avg_score)!})
        
        top10SchoolsScores = Array(sortedSATData[0...9])
        
    }
    
    func getTopSchools() {
        for i in top10SchoolsScores {
            for j in schoolsData {
                if i.dbn == j.dbn {
                    top10Schools.append(j)
                }
            }
        }
    }
    
}
