//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolsListViewController: UIViewController {

    private(set) var viewModel: SchoolsListViewModeling
    weak var coordinator: SchoolsListCoordinator?

    required init(viewModel: SchoolsListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchController.searchBar
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools..."
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Sort By", style: .plain, target: self, action: #selector(searchTapped))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    //MARK: When View Is Removed This deinits The Coordinator
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent { coordinator?.didFinish() }
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "Search Schools"
        
        schoolsTableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.reuseID)
    }
    
    private func layout() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self

        view.addSubview(schoolsTableView)

        NSLayoutConstraint.activate([
            schoolsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func searchTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add your choices
        actionSheet.addAction(UIAlertAction(title: "Choice 1", style: .default, handler: { _ in
            // Handle Choice 1
            print("Choice 1 selected")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choice 2", style: .default, handler: { _ in
            // Handle Choice 2
            print("Choice 2 selected")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choice 3", style: .default, handler: { _ in
            // Handle Choice 3
            print("Choice 3 selected")
        }))
        
        // Add cancel action
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SchoolsListViewController: UITableViewDataSource {
    //MARK: Reuses Cells For Memory Optimization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let schoolCell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.reuseID, for: indexPath) as? SchoolTableViewCell else {
            print("Unable to dequeue SchoolTableViewCell")
            
            return UITableViewCell()
        }
        
        schoolCell.configure(viewModel: viewModel, indexPath: indexPath)
        
        return schoolCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumOfRowsInSection()
    }
    
    //MARK: Ensures There Are 4 Cells Shown At A Time Regardless Of Screen Size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.bounds.height/5)
    }
}

extension SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToSchoolView(school: viewModel.getSchool(indexPath: indexPath), satData: viewModel.getSATData(indexPath: indexPath))
    }
}

extension SchoolsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.textChanged(searchText: searchController.searchBar.text ?? "")
        schoolsTableView.reloadData()
    }
}

