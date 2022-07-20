//
//  Top10SchoolsListViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

class TopSchoolsListViewController: UIViewController {
    
    let schoolsTableView = UITableView()
    let topSchoolsHeaderView = TopSchoolsHeaderView()
    
    let topSchoolsViewModel: TopSchoolsListViewModel
    
    required init(viewModel: TopSchoolsListViewModel) {
        self.topSchoolsViewModel = viewModel
        self.topSchoolsViewModel.getTopSchools()
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
        view.backgroundColor = .white
        
        topSchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsHeaderView.layer.cornerRadius = 35
        topSchoolsHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topSchoolsHeaderView.backgroundColor = UIColor.systemBlue
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(topSchoolsHeaderView)
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            topSchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topSchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            schoolsTableView.topAnchor.constraint(equalTo: topSchoolsHeaderView.bottomAnchor),
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

extension TopSchoolsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: topSchoolsViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoro.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoro.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSchoolsViewModel.topSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension TopSchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(SchoolTabBarViewController(school: topSchoolsViewModel.topSchools[indexPath.row], scores: topSchoolsViewModel.topSchoolsScores[indexPath.row]), animated: true)
    }
}
