//
//  CalculatedSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class CalculatedSchoolsViewController: UIViewController {
    
    let schoolsTableView = UITableView()
    let viewModel: SchoolsCalculatorViewModel
    
    required init(viewModel: SchoolsCalculatorViewModel) {
        self.viewModel = viewModel
        print("GGG")
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
}

extension CalculatedSchoolsViewController {
    
    func style() {
        view.backgroundColor = .white
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    
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
}

extension CalculatedSchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: viewModel.getInfo(for: indexPath))
        schoolCell.schoolBoro.text = "#\(indexPath.row + 1)"
        schoolCell.schoolBoro.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension CalculatedSchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(SchoolTabBarViewController(school: viewModel.schoolsData[indexPath.row], scores: viewModel.schoolsSATData[indexPath.row]), animated: true)
    }
}

