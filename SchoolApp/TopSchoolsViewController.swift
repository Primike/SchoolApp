//
//  Top10SchoolsListViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

class TopSchoolsViewController: UIViewController {
    
    lazy var topSchoolsHeaderView: TopSchoolsHeaderView = {
        var view = TopSchoolsHeaderView(viewWidth: view.bounds.width)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        return view
    }()
    
    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    let topSchoolsViewModel: TopSchoolsViewModel
    weak var coordinator: TopSchoolsCoordinator?
    
    required init(viewModel: TopSchoolsViewModel) {
        self.topSchoolsViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        topSchoolsHeaderView.searchButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            coordinator?.didFinish()
        }
    }

    private func layout() {
        view.addSubview(topSchoolsHeaderView)
        view.addSubview(schoolsTableView)
        
        NSLayoutConstraint.activate([
            topSchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            topSchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topSchoolsHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            schoolsTableView.topAnchor.constraint(equalTo: topSchoolsHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension TopSchoolsViewController {
    @objc func submitButtonTapped(sender: UIButton) {
        topSchoolsHeaderView.errorLabel.isHidden = true
        let selectedIndex = topSchoolsHeaderView.segmentedControl.selectedSegmentIndex

        guard let inputText = topSchoolsHeaderView.numberTextField.text, !inputText.isEmpty else {
            topSchoolsViewModel.getTopSchools(selectedSegment: selectedIndex, number: 5)
            schoolsTableView.reloadData()
            return
        }
        
        guard let inputNumber = Int(inputText) else {
            errorHandler(message: "Please enter an integer value")
            return
        }

        if inputNumber < 0 || inputNumber > topSchoolsViewModel.schoolsScores.count {
            errorHandler(message: "Please type in values between 0 and \(topSchoolsViewModel.schoolsScores.count)")
            return
        }

        topSchoolsViewModel.getTopSchools(selectedSegment: selectedIndex, number: inputNumber)
        schoolsTableView.reloadData()
    }

    func errorHandler(message: String) {
        topSchoolsHeaderView.errorLabel.isHidden = false
        topSchoolsHeaderView.errorLabel.text = message
    }
}

extension TopSchoolsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: topSchoolsViewModel, indexPath: indexPath)
        schoolCell.schoolBoroLabel.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoroLabel.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSchoolsViewModel.topSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let school = topSchoolsViewModel.getSchool(index: indexPath) else {
            return
        }
        
        coordinator?.goToSchoolView(school: school, schoolScores: topSchoolsViewModel.getSATScores(index: indexPath))
    }
}
