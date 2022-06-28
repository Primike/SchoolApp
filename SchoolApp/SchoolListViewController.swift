//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolListViewController: UIViewController {
        
    let schoolsListHeader = SchoolsListHeaderView(frame: .zero)

    let schoolsTableView = UITableView()
    let schoolsSearchBar = UISearchBar()
    let dispatchGroup = DispatchGroup()
    
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    var schoolsSearchResults = [School]()
    var searchBarUsed = false
    var completedAPIFetches = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchoolsData()
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dispatchGroup.notify(queue: .main, execute: {
            if self.completedAPIFetches == 2 {
                self.view.backgroundColor = .white
                self.style()
                self.layout()
                self.setup()
                activityIndicator.stopAnimating()
            }
        })
    }
    
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    func getSchoolsData() {
        dispatchGroup.enter()
        SchoolServiceAPI.shared.getSchoolsData { result in
            defer {
                self.dispatchGroup.leave()
            }
            
            switch result {
            case .success(let schools):
                self.schoolsData = schools
                self.schoolsSearchResults = self.schoolsData
                self.completedAPIFetches += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        dispatchGroup.enter()
        SchoolServiceAPI.shared.getTestData { result in
            defer {
                self.dispatchGroup.leave()
            }
            
            switch result {
            case .success(let scores):
                self.schoolsSATData = scores
                self.completedAPIFetches += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SchoolListViewController {
    
    func style() {
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = schoolsSearchBar
        schoolsSearchBar.searchBarStyle = UISearchBar.Style.default
        schoolsSearchBar.placeholder = "Search Schools"
        schoolsSearchBar.sizeToFit()
        schoolsSearchBar.isTranslucent = false
    }
    
    func layout() {
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            schoolsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            schoolsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
        schoolsSearchBar.delegate = self
        
        var size = schoolsListHeader.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        schoolsListHeader.frame.size = size
        schoolsTableView.tableHeaderView = schoolsListHeader
    }
    
}

extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchBarUsed == true {
            return setupCell(data: schoolsSearchResults, indexPath: indexPath)
        } else {
            return setupCell(data: schoolsSearchResults, indexPath: indexPath)
        }
    }
    
    func setupCell(data: [School], indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        let schoolColor = getColor(school: schoolsSearchResults[indexPath.row])
        
        schoolCell.schoolName.text = data[indexPath.row].school_name
        schoolCell.schoolAddress.text = data[indexPath.row].location
        schoolCell.schoolBoro.text = data[indexPath.row].boro
        schoolCell.schoolBoro.textColor = schoolColor
        schoolCell.schoolName.textColor = schoolColor
        
        return schoolCell
    }
    
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  searchBarUsed == true {
            return schoolsSearchResults.count
        } else {
            return schoolsData.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var schoolSATScores: SchoolScores?
        let scoresNotAvailable = SchoolScores(dbn: "0", num_of_sat_test_takers: "Not Available",                                              sat_critical_reading_avg_score: "0",
                                       sat_math_avg_score: "0",
                                       sat_writing_avg_score: "0")
        
        for data in schoolsSATData {
            if data.dbn == schoolsSearchResults[indexPath.row].dbn {
                schoolSATScores = data
                break
            }
        }
        navigationController?.pushViewController(SchoolTabBarViewController(school: schoolsSearchResults[indexPath.row], scores: schoolSATScores ?? scoresNotAvailable, schoolColor: getColor(school: schoolsSearchResults[indexPath.row])), animated: true)
    }
}

//\\\\\\\\\\\\\\\\\\\\\\\\
extension SchoolListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            schoolsSearchResults =
            schoolsData.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            searchBarUsed = true
            schoolsTableView.reloadData()
        } else {
            searchBarUsed = false
            schoolsTableView.reloadData()
        }
    }
}
    
