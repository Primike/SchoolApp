//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolListViewController: UIViewController {
    
    //variables to store api info
    var testData = [SchoolScore]()
    var group = DispatchGroup()
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var completedAPICount = 0
    let urls = ["https://data.cityofnewyork.us/resource/s3k6-pzi2.json", "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"]
    var schoolServiceApi = SchoolServiceAPI()
    var schoolData = [School]()
    var schoolsSATData = [SchoolScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        activityIndicator.color = .red
        getData()
        //used this so that the code waits for the api data to fill
        print("done")
    }
    
    func getData(){
        group.enter()
        let task = URLSession.shared.dataTask(with: URL(string: urls[0])!) { data, response, error in
            defer {
                self.group.leave()
            }
            if let data = data {
                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as? [[String: Any]]) != nil {
                    self.schoolData = try! JSONDecoder().decode([School].self, from: data)
                }
            }
        }
        task.resume()
        group.notify(queue: .main, execute: {
            self.completedAPICount += 1
            if self.completedAPICount == 2 {
                self.view.backgroundColor = .systemTeal
                self.style()
                self.layout()
                self.setup()
            }
        })

        group.enter()
        let task2 = URLSession.shared.dataTask(with: URL(string: urls[1])!) { data, response, error in
            defer {
                self.group.leave()
            }
            if let data = data {
                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as? [[String: Any]]) != nil {
                    self.testData = try! JSONDecoder().decode([SchoolScore].self, from: data)
                }
            }
        }
        task2.resume()
        group.notify(queue: .main, execute: {
            self.completedAPICount += 1
            if self.completedAPICount == 2 {
                self.view.backgroundColor = .systemTeal
                self.style()
                self.layout()
                self.setup()
            }
        })
    }
}
















//setting up stuff here in this extension
extension SchoolListViewController {
    func style(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    func layout(){
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
        
        //        let header = SchoolListHeader(frame: .zero)
        //        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        //        size.width = UIScreen.main.bounds.width
        //        header.frame.size = size
        //        tableView.tableHeaderView = header
    }
    
}

//this extension sets up the table properties
extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SchoolTableViewCell()
        cell.schoolNameLabel.text = schoolData[indexPath.row].school_name
        cell.schoolNameLabel.numberOfLines = 0
        cell.addressLabel.text = schoolData[indexPath.row].location
        cell.addressLabel.numberOfLines = 0
        cell.boroLabel.text = schoolData[indexPath.row].boro
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

//this extension allows table cells to be clickable and present another VC
extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var modifiedTestData: SchoolScore?
        let notAvailable = SchoolScore(dbn: "0", num_of_sat_test_takers: "Not Available",                                              sat_critical_reading_avg_score: "Not Available",
                                       sat_math_avg_score: "Not Available",
                                       sat_writing_avg_score: "Not Available")
        
        //if a school does not have test data in the testData api then
        //i am adding a generic not available for that dbn
        for i in testData {
            if i.dbn == schoolData[indexPath.row].dbn {
                modifiedTestData = i
                break
            }
        }
        
        navigationController?.pushViewController(TabBarViewController(school: schoolData[indexPath.row], tests: modifiedTestData ?? notAvailable), animated: true)
    }
}
