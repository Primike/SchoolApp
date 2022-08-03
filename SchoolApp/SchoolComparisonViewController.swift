//
//  SchoolComparisonViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

//fix double click same cell
class SchoolComparisonViewController: UIViewController {
    
    let mySchoolsHeaderView = MySchoolsHeaderView()
    let schoolsTableView = UITableView()
    
    var number = 0
    var cellIndex1 = 0
    var cellIndex2 = 1

    let mySchoolsViewModel: MySchoolsViewModel
    
    required init(viewModel: MySchoolsViewModel) {
        self.mySchoolsViewModel = viewModel
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func style() {
        view.backgroundColor = .white
        
        mySchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(mySchoolsHeaderView)
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            mySchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mySchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            mySchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mySchoolsHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: mySchoolsHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
    }

}

extension SchoolComparisonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: mySchoolsViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoroLabel.text = "\(indexPath.row + 1)"
        schoolCell.selectionStyle = .gray
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySchoolsViewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension SchoolComparisonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        number = number + 1
        schoolsTableView.cellForRow(at: indexPath)?.isHighlighted = true
        if number == 2 {
            navigationController?.present(ComparisonViewController(school1: mySchoolsViewModel.schools[cellIndex1], scores1: mySchoolsViewModel.schoolsScores[cellIndex1], school2: mySchoolsViewModel.schools[indexPath.row], scores2: mySchoolsViewModel.schoolsScores[indexPath.row]), animated: true)
            number = 0
            schoolsTableView.reloadData()
        } else {
            cellIndex1 = indexPath.row
        }
    }
}

