//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolsListViewController: UIViewController {

    //replace this view
    let schoolsListHeader = SchoolsListHeaderView(frame: .zero)

    let schoolsTableView = UITableView()
    let schoolsSearchBar = UISearchBar()
    
    let schoolsListViewModel: SchoolsListViewModel
    
    required init(viewModel: SchoolsListViewModel) {
        self.schoolsListViewModel = viewModel

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
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = schoolsSearchBar
        schoolsSearchBar.searchBarStyle = UISearchBar.Style.default
        schoolsSearchBar.placeholder = "Search Schools"
        schoolsSearchBar.sizeToFit()
        schoolsSearchBar.isTranslucent = false
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
        schoolsSearchBar.delegate = self
        
        var size = schoolsListHeader.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        schoolsListHeader.frame.size = size
        schoolsTableView.tableHeaderView = schoolsListHeader
    }
}

extension SchoolsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: schoolsListViewModel.getInfo(for: indexPath))

        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolsListViewModel.schoolsSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolsListViewModel.rowSelectSearch(indexPath: indexPath)
        
        navigationController?.pushViewController(SchoolTabBarViewController(school: schoolsListViewModel.schoolsSearchResults[indexPath.row], scores: schoolsListViewModel.schoolScores ?? schoolsListViewModel.scoresNotAvailable), animated: true)
    }
}

extension SchoolsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        schoolsListViewModel.textChanged(searchText: searchText)
        schoolsTableView.reloadData()
    }
}
    


