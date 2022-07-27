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
    
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    
    init() {
        self.state = .idle
    }
    
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
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}

