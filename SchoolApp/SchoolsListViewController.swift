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
                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    //MARK: When View Is Removed This deinits The Coordinator
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            coordinator?.didFinish()
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationItem.titleView = schoolsSearchBar
        
        schoolsTableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.reuseID)
    }
    
    private func layout() {
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

extension SchoolsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textChanged(searchText: searchText)
        schoolsTableView.reloadData()
    }
}

