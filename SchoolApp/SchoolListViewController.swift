//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolListViewController: UIViewController {
        
    var satData = [SchoolScore]()
    var schoolData = [School]()
    
    var schoolDataSearchResults = [School]()
    var isSearched = false
    
    var group = DispatchGroup()
    let header = SchoolListHeaderView(frame: .zero)
    let loadingView = LoadingView()
    var tableView = UITableView()
    let searchBar = UISearchBar()
    var completedAPICount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(loadingView)
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true

        getData()
        
        group.notify(queue: .main, execute: {
            if self.completedAPICount == 2 {
                self.loadingView.stopActivityIndicator()
                self.view.backgroundColor = .white
                self.style()
                self.layout()
                self.setup()
            }
        })
    }
    

    func getData() {
        group.enter()
        SchoolServiceAPI.shared.getSchoolData { result in
            defer {
                self.group.leave()
            }
            switch result {
            case .success(let schools):
                self.schoolData = schools
                self.schoolDataSearchResults = self.schoolData
                self.completedAPICount += 1
                print(schools[0].website)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        group.enter()
        SchoolServiceAPI.shared.getTestData { result in
            defer {
                self.group.leave()
            }
            switch result {
            case .success(let scores):
                self.satData = scores
                self.completedAPICount += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



extension SchoolListViewController {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search Schools"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        navigationItem.titleView = searchBar
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        tableView.tableHeaderView = header
    }
    
}

extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SchoolTableViewCell()

        if isSearched == false {
            cell.schoolNameLabel.text = schoolData[indexPath.row].school_name
            cell.addressLabel.text = schoolData[indexPath.row].location
            cell.boroLabel.text = schoolData[indexPath.row].boro
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            switch schoolData[indexPath.row].boro {
            case "M":
                cell.boroLabel.textColor = UIColor.systemBlue
                cell.schoolNameLabel.textColor = UIColor.systemBlue
            case "X":
                cell.boroLabel.textColor = .systemOrange
                cell.schoolNameLabel.textColor = .systemOrange
            case "K":
                cell.boroLabel.textColor = UIColor.black
                cell.schoolNameLabel.textColor = UIColor.black
            case "Q":
                cell.boroLabel.textColor = UIColor.systemPurple
                cell.schoolNameLabel.textColor = UIColor.systemPurple
        
            default:
                cell.boroLabel.textColor = .systemGreen
                cell.schoolNameLabel.textColor = .systemGreen
            }
            return cell
        } else {
            cell.schoolNameLabel.text = schoolDataSearchResults[indexPath.row].school_name
            cell.schoolNameLabel.numberOfLines = 0
            cell.addressLabel.text = schoolDataSearchResults[indexPath.row].location
            cell.addressLabel.numberOfLines = 0
            cell.boroLabel.text = schoolDataSearchResults[indexPath.row].boro
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            switch schoolDataSearchResults[indexPath.row].boro {
            case "M":
                cell.boroLabel.textColor = UIColor.systemBlue
                cell.schoolNameLabel.textColor = UIColor.systemBlue
            case "X":
                cell.boroLabel.textColor = .systemOrange
                cell.schoolNameLabel.textColor = .systemOrange
            case "K":
                cell.boroLabel.textColor = UIColor.black
                cell.schoolNameLabel.textColor = UIColor.black
            case "Q":
                cell.boroLabel.textColor = UIColor.systemPurple
                cell.schoolNameLabel.textColor = UIColor.systemPurple
        
            default:
                cell.boroLabel.textColor = .systemGreen
                cell.schoolNameLabel.textColor = .systemGreen
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  isSearched == true {
            return schoolDataSearchResults.count
        } else {
            return schoolData.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var modifiedTestData: SchoolScore?
        let notAvailable = SchoolScore(dbn: "0", num_of_sat_test_takers: "Not Available",                                              sat_critical_reading_avg_score: "0",
                                       sat_math_avg_score: "0",
                                       sat_writing_avg_score: "0")
        
        for i in satData {
            if i.dbn == schoolDataSearchResults[indexPath.row].dbn {
                modifiedTestData = i
                break
            }
        }
        navigationController?.pushViewController(TabBarViewController(school: schoolDataSearchResults[indexPath.row], tests: modifiedTestData ?? notAvailable), animated: true)
        navigationController?.title = schoolDataSearchResults[indexPath.row].school_name
    }
}

extension SchoolListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            schoolDataSearchResults =
            schoolData.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            isSearched = true
            tableView.reloadData()
        } else {
            isSearched = false
            tableView.reloadData()
        }
    }
}
        
