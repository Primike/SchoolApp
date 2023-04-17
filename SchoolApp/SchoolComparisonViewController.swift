//
//  SchoolComparisonViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class SchoolComparisonViewController: UIViewController {
    
    lazy var comparisonHeaderView: ComparisonHeaderView = {
        var view = ComparisonHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let mySchoolsViewModel: MySchoolsViewModel
    weak var coordinator: SchoolComparisonCoordinator?
    var number = 0
    var cellIndex1 = 0
    
    required init(viewModel: MySchoolsViewModel) {
        self.mySchoolsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mySchoolsViewModel.mySchools()
        schoolsTableView.reloadData()
    }
    
    deinit {
        print("comparisonVC")
    }
    func layout() {
        view.addSubview(comparisonHeaderView)
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            comparisonHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            comparisonHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            comparisonHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            comparisonHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: comparisonHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SchoolComparisonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: mySchoolsViewModel, indexPath: indexPath)
        schoolCell.schoolBoroLabel.text = "\(indexPath.row + 1)"
        schoolCell.selectionStyle = .gray
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySchoolsViewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
}

extension SchoolComparisonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if cellIndex1 == indexPath.row && number == 1 {
            number = 0
            schoolsTableView.cellForRow(at: indexPath)?.isHighlighted = false
            schoolsTableView.reloadData()
        } else {
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
}

