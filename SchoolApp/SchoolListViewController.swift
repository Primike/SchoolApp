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
    
    var group = DispatchGroup()
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var completedAPICount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        activityIndicator.color = .red

        getData()
        
        group.notify(queue: .main, execute: {
            if self.completedAPICount == 2 {
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
                self.completedAPICount += 1
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
        
        let header = SchoolListHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        tableView.tableHeaderView = header
    }
    
}

extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SchoolTableViewCell()
        cell.schoolNameLabel.text = schoolData[indexPath.row].school_name
        cell.schoolNameLabel.numberOfLines = 0
        cell.addressLabel.text = schoolData[indexPath.row].location
        cell.addressLabel.numberOfLines = 0
        cell.boroLabel.text = schoolData[indexPath.row].boro
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        switch schoolData[indexPath.row].boro {
        case "M":
            cell.boroLabel.textColor = UIColor.gray
            cell.schoolNameLabel.textColor = UIColor.gray
        case "X":
            cell.boroLabel.textColor = .systemOrange
            cell.schoolNameLabel.textColor = .systemOrange
        case "K":
            cell.boroLabel.textColor = UIColor.black
            cell.schoolNameLabel.textColor = UIColor.black
        case "Q":
            cell.boroLabel.textColor = UIColor.systemBlue
            cell.schoolNameLabel.textColor = UIColor.systemBlue
    
        default:
            cell.boroLabel.textColor = .systemGreen
            cell.schoolNameLabel.textColor = .systemGreen
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolData.count
        //return schoolDataSearchResults.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var modifiedTestData: SchoolScore?
        let notAvailable = SchoolScore(dbn: "0", num_of_sat_test_takers: "Not Available",                                              sat_critical_reading_avg_score: "0",
                                       sat_math_avg_score: "0",
                                       sat_writing_avg_score: "0")
        
        for i in satData {
            if i.dbn == schoolData[indexPath.row].dbn {
                modifiedTestData = i
                break
            }
        }
        navigationController?.pushViewController(TabBarViewController(school: schoolData[indexPath.row], tests: modifiedTestData ?? notAvailable), animated: true)
        navigationController?.title = schoolData[indexPath.row].school_name
    }
}
