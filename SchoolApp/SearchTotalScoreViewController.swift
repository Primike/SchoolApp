//
//  SearchSATScoreViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchTotalScoreViewController: UIViewController {
    
    lazy var searchSATScoresHeaderView: SearchScoresHeaderView = {
        var view = SearchScoresHeaderView()
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    
    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let searchSATScoreViewModel: SearchSATScoresViewModel
    weak var coordinator: SATSearchCoordinator?
    
    required init(viewModel: SearchSATScoresViewModel) {
        self.searchSATScoreViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        searchSATScoresHeaderView.searchButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)

        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            coordinator?.didFinish()
        }
    }

    func layout() {
        view.addSubview(searchSATScoresHeaderView)
        view.addSubview(schoolsTableView)
                
        NSLayoutConstraint.activate([
            searchSATScoresHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchSATScoresHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            searchSATScoresHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchSATScoresHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: searchSATScoresHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

extension SearchTotalScoreViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        searchSATScoresHeaderView.errorLabel.isHidden = true
        let selectedIndex = searchSATScoresHeaderView.segmentedControl.selectedSegmentIndex

        guard let totalScoreText = searchSATScoresHeaderView.totalScoreText.text,
              let schoolNumberText = searchSATScoresHeaderView.schoolNumberText.text,
              !totalScoreText.isEmpty, !schoolNumberText.isEmpty else {
            errorHandler(message: "Insert A Value")
            return
        }

        guard let totalScore = Int(totalScoreText), let schoolNumber = Int(schoolNumberText) else {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }

        if totalScore < 200 || totalScore > 2400 {
            errorHandler(message: "Please Type In Scores Between 600 And 2400")
            return
        }

        searchSATScoreViewModel.getTopSchools(selectedSegment: selectedIndex, number: schoolNumber, score: totalScore)
        schoolsTableView.reloadData()
    }

    func errorHandler(message: String){
        searchSATScoresHeaderView.errorLabel.isHidden = false
        searchSATScoresHeaderView.errorLabel.text = message
    }
}

extension SearchTotalScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(viewModel: searchSATScoreViewModel, indexPath: indexPath)
        schoolCell.schoolBoroLabel.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoroLabel.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSATScoreViewModel.calculatedSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(view.bounds.height/5))
    }
}

extension SearchTotalScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        coordinator?.goToSchoolView(school: searchSATScoreViewModel.calculatedSchools[indexPath.row], schoolScores: searchSATScoreViewModel.calculatedSchoolsScores[indexPath.row])
    }
}
