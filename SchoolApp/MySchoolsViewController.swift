//
//  MySchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewController: UIViewController {
    
    let mySchoolsHeaderView = MySchoolsHeaderView()
    let schoolsTableView = UITableView()
    
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
        mySchoolsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mySchoolsViewModel.mySchools()
        schoolsTableView.reloadData()
        mySchoolsEmpty()
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
    
    func mySchoolsEmpty() {
        if mySchoolsViewModel.schools.count > 0 {
            mySchoolsHeaderView.mySchoolsLabel.text = "My Schools"
        }
    }
}

extension MySchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: mySchoolsViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoroLabel.text = "\(indexPath.row + 1)"
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySchoolsViewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
}

extension MySchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.present(SchoolTabBarViewController(school: mySchoolsViewModel.schools[indexPath.row], scores: mySchoolsViewModel.schoolsScores[indexPath.row]), animated: true)
    }
}
