//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolsListViewController: UIViewController {

    lazy var schoolsListHeader: SchoolsListHeaderView = {
        let headerView = SchoolsListHeaderView(frame: .zero)
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        return headerView
    }()

    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = schoolsListHeader
        return tableView
    }()
    
    lazy var schoolsSearchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search Schools"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()
        
    let viewModel: SchoolsListViewModel
    var coordinator: SchoolsListCoordinator?

    required init(viewModel: SchoolsListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("viewcontroller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.titleView = schoolsSearchBar

        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissViewController()
        }
    }
    
    func dismissViewController() {
        coordinator?.didFinish()
        // Dismiss or pop the view controller as needed
    }

    func layout() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
        schoolsSearchBar.delegate = self

        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            schoolsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SchoolsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: viewModel, indexPath: indexPath)

        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
}

extension SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelectSearch(indexPath: indexPath)
        
        navigationController?.pushViewController(SchoolTabBarViewController(school: viewModel.schoolSearchResults[indexPath.row], scores: viewModel.schoolScores), animated: true)
    }
}

extension SchoolsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textChanged(searchText: searchText)
        schoolsTableView.reloadData()
    }
}

