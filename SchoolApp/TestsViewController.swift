//
//  TestsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class TestsViewController: UIViewController {
    let testsTableView = UITableView()
    
    var school: School
    var tests: SchoolScore
    var testScores = [String]()
    let testNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]
    
    init(school: School, tests: SchoolScore) {
        self.school = school
        self.tests = tests
        testScores.append(tests.sat_math_avg_score)
        testScores.append(tests.sat_writing_avg_score)
        testScores.append(tests.sat_critical_reading_avg_score)
        print(testScores)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        testsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(testsTableView)
        
        NSLayoutConstraint.activate([
            testsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            testsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            testsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            testsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setup() {
        testsTableView.delegate = self
        testsTableView.dataSource = self
    }

}


extension TestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SchoolTableViewCell()
        cell.schoolNameLabel.text = testNames[indexPath.row]
        cell.schoolNameLabel.numberOfLines = 0
        cell.addressLabel.text = "Click to view scores"
        cell.addressLabel.numberOfLines = 0
        cell.boroLabel.text = school.boro
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testNames.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension TestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TestGraphViewController(testScorez: testScores[indexPath.row], name: testNames[indexPath.row]), animated: true)    }
}

