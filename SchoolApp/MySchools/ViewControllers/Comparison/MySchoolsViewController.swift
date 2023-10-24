//
//  MySchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewController: UIViewController {
    
    lazy var mySchoolsHeaderView: MySchoolsHeaderView = {
        var view = MySchoolsHeaderView()
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
    weak var coordinator: MySchoolsCoordinator?
    
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
        mySchoolsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mySchoolsViewModel.mySchools()
        schoolsTableView.reloadData()
        mySchoolsEmpty()
    }
            
    func mySchoolsEmpty() {
        if mySchoolsViewModel.schoolsData.count > 0 {
            mySchoolsHeaderView.mySchoolsLabel.text = "My Schools"
        }
    }
    
    func layout() {
        view.addSubview(mySchoolsHeaderView)
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            mySchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mySchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            mySchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mySchoolsHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: mySchoolsHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension MySchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: mySchoolsViewModel, indexPath: indexPath)
        schoolCell.schoolBoro.text = "\(indexPath.row + 1)"
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySchoolsViewModel.schoolsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
}

extension MySchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolsTableView.reloadData()
    
        
        coordinator?.goToSchoolView(schoolData: mySchoolsViewModel.schoolsData[indexPath.row])
    }
}
