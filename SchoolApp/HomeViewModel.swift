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
    
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    var top10SchoolsScores = [SchoolScores]()
    var top10Schools = [School]()
    
    func getSchools() {
        self.state = .loading
        SchoolServiceAPI.shared.getSchoolsData { result in
            switch result {
            case .success(let schools):
                self.schools = schools
                self.getSchoolScores()
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    func getSchoolScores() {
        SchoolServiceAPI.shared.getTestData { result in
            switch result {
            case .success(let scores):
                self.schoolsScores = scores
                self.getTopSchools()
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}

extension HomeViewModel {
    //maybe add a int for number of top schools
    func getTopSchools() {
        for i in 0..<schoolsScores.count {
            if Int(schoolsScores[i].sat_critical_reading_avg_score) != nil && Int(schoolsScores[i].sat_math_avg_score) != nil && Int(schoolsScores[i].sat_writing_avg_score) != nil {
            } else {
                schoolsScores[i] = SchoolScores(dbn: schoolsScores[i].dbn, num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0",
                                      sat_math_avg_score: "0",
                                      sat_writing_avg_score: "0")
            }
        }
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_critical_reading_avg_score)! + Int($0.sat_math_avg_score)! + Int($0.sat_writing_avg_score)! > Int($1.sat_critical_reading_avg_score)! + Int($1.sat_math_avg_score)! + Int($1.sat_writing_avg_score)!})
        
//        let x = Array(schoolsScores[10...15])
        
        
        //maybe let user select how many top schools
        for i in 0..<sortedScores.count {
            if top10SchoolsScores.count != 10 {
                if let school = schools.first(where: {$0.dbn == sortedScores[i].dbn}) {
                    top10SchoolsScores.append(sortedScores[i])
                    top10Schools.append(school)
                }
            } else {
                break
            }
        }
    }
}
