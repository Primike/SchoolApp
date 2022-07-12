//
//  MySchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewController: UIViewController {
    let schoolsTableView = UITableView()
    let viewModel: MySchoolsViewModel
    
    required init(viewModel: MySchoolsViewModel) {
        self.viewModel = viewModel
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
        viewModel.mySchools()
        schoolsTableView.reloadData()

    }
}

extension MySchoolsViewController {
    
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
}

extension MySchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: viewModel.getInfo(for: indexPath))
        schoolCell.schoolBoro.text = "\(indexPath.row + 1)"
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension MySchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(SchoolTabBarViewController(school: viewModel.schoolsData[indexPath.row], scores: viewModel.schoolsSATData[indexPath.row] , schoolColor: viewModel.getColor(school: viewModel.schoolsData[indexPath.row])), animated: true)
    }
}
