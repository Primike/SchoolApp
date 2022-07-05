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
            print("UPdated with \(state)")
            self.delegate?.didUpdate(with: state)
        }
    }
    
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    
    init() {
        self.state = .idle
    }
    
    var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        return activityIndicator
    }
}

extension SchoolsListViewModel {
    func loadData() {
        self.state = .loading
        SchoolServiceAPI.shared.getSchoolsData { result in
            switch result {
            case .success(let schools):
                self.schoolsData = schools
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
