//
//  Top10SchoolsListViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

class Top10SchoolsListViewController: UIViewController {
    
    let schoolsTableView = UITableView()
    let top10SchoolsHeaderView = Top10SchoolsHeaderView()
    
    let top10SchoolsViewModel: Top10SchoolsListViewModel
    
    required init(viewModel: Top10SchoolsListViewModel) {
        self.top10SchoolsViewModel = viewModel
        
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
        
        top10SchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        top10SchoolsHeaderView.layer.cornerRadius = 35
        top10SchoolsHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        top10SchoolsHeaderView.backgroundColor = UIColor.systemBlue
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(top10SchoolsHeaderView)
        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            top10SchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            top10SchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            top10SchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            schoolsTableView.topAnchor.constraint(equalTo: top10SchoolsHeaderView.bottomAnchor),
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

extension Top10SchoolsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: top10SchoolsViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoro.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoro.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top10SchoolsViewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension Top10SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(SchoolTabBarViewController(school: top10SchoolsViewModel.schools[indexPath.row], scores: top10SchoolsViewModel.schoolsScores[indexPath.row]), animated: true)
    }
}
