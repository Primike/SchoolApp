//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit

class SchoolsListViewController: UIViewController {

    let schoolsListHeader = SchoolsListHeaderView(frame: .zero)

    let schoolsTableView = UITableView()
    let schoolsSearchBar = UISearchBar()
    let schoolsViewModel: SchoolsListViewModel
    
    required init(viewModel: SchoolsListViewModel) {
        self.schoolsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.schoolsViewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        schoolsViewModel.loadData()

        
    }
}

extension SchoolsListViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                print("loadingzz")
            case .success:
//                print("successzz")
                self.schoolsTableView.reloadData()
                self.style()
                self.layout()
                self.setup()
            case .error(let error):
                self.showAlert(error: error.localizedDescription)
            }
        }
    }
    
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { _ in
//            exit(0)
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.schoolsViewModel.loadData()
        }))
        
        present(alert, animated: true)
    }
}
extension SchoolsListViewController {
    
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
        schoolCell.configure(info: schoolsViewModel.getInfo(for: indexPath))

        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolsViewModel.schoolsSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolsViewModel.rowSelectSearch(indexPath: indexPath)
        
        navigationController?.pushViewController(SchoolTabBarViewController(school: schoolsViewModel.schoolsSearchResults[indexPath.row], scores: schoolsViewModel.schoolSATScores ?? schoolsViewModel.scoresNotAvailable, schoolColor: schoolsViewModel.getColor(school: schoolsViewModel.schoolsSearchResults[indexPath.row])), animated: true)
    }
}

extension SchoolsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        schoolsViewModel.textChanged(searchText: searchText)
        schoolsTableView.reloadData()
    }
}
    


