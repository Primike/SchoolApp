//
//  MySchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/12/22.
//

import Foundation
import UIKit

class MySchoolsViewController: UIViewController {
    
    weak var coordinator: MySchoolsCoordinator?
    private let mySchoolsViewModel: MySchoolsViewModel
    var compareClicked = false
    var selectedCount = 0
    var cellIndex1 = 0

    required init(viewModel: MySchoolsViewModel) {
        self.mySchoolsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        return stackView
    }()
    
    lazy var headerView: MySchoolsHeaderView = {
        var view = MySchoolsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var compareButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Compare Two", style: .plain, target: self, action: #selector(compareTapped))
        return button
    }()
                     
    private func setup() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = compareButton

        if mySchoolsViewModel.schoolsData.count > 0 {
            headerView.mySchoolsLabel.text = "My Schools"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDataUpdate), name: .userDataDidUpdate, object: nil)
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(tableView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.15),
        ])
    }

    // MARK: - If Compare Button Tapped VC Goes Into Compare Mode
    @objc func compareTapped() {
        compareClicked = !compareClicked
        compareButton.title = compareClicked ? "Cancel" : "Compare Two"

        tableView.allowsMultipleSelection = compareClicked  // <-- This line enables multiple selection

        if !compareClicked {
            for indexPath in tableView.indexPathsForSelectedRows ?? [] {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        tableView.reloadData()
    }

    // MARK: - If Add School Selected/Deselected In School View The TableView Will Reload
    @objc func handleUserDataUpdate() {
        DispatchQueue.main.async {
            self.mySchoolsViewModel.mySchools()
            self.tableView.reloadData()
        }
    }
}

extension MySchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: mySchoolsViewModel, indexPath: indexPath)
        schoolCell.schoolBoro.text = "\(indexPath.row + 1)"
        schoolCell.selectionStyle = .none
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
        if compareClicked {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark

            // MARK: Transition To The Comparison View When Two Schools Are Selected
            if let selectedRows = tableView.indexPathsForSelectedRows, selectedRows.count == 2 {
                let school1 = mySchoolsViewModel.schoolsData[selectedRows[0].row]
                let school2 = mySchoolsViewModel.schoolsData[selectedRows[1].row]
                coordinator?.goToComparison(school1: school1, school2: school2)

                for indexPath in selectedRows {
                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
                }
            }
        } else {
            coordinator?.goToSchoolView(schoolData: mySchoolsViewModel.schoolsData[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if compareClicked {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
}
