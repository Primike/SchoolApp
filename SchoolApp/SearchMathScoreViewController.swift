//
//  SearchMathScoreViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchMathScoreViewController: UIViewController {
    
    let searchSATScoresHeaderView = SearchScoresHeaderView()
    let schoolsTableView = UITableView()
    let mathScoreText = UITextField()
    let schoolNumberText = UITextField()
    let errorLabel = UILabel()
    let enterButton = UIButton()
        
    let searchSATScoreViewModel: SearchSATScoresViewModel
    
    required init(viewModel: SearchSATScoresViewModel) {
        self.searchSATScoreViewModel = viewModel

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
        
        searchSATScoresHeaderView.translatesAutoresizingMaskIntoConstraints = false
        searchSATScoresHeaderView.layer.cornerRadius = 40
        searchSATScoresHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner]
        searchSATScoresHeaderView.backgroundColor = UIColor.systemGreen
        
        searchSATScoresHeaderView.topSchoolsLabel.text = "Search Schools By Math Score"
        
        mathScoreText.translatesAutoresizingMaskIntoConstraints = false
        mathScoreText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        mathScoreText.adjustsFontSizeToFitWidth = true
        mathScoreText.textAlignment = .center
        mathScoreText.layer.borderWidth = 3
        mathScoreText.layer.cornerRadius = 7.0
        mathScoreText.textColor = .white
        mathScoreText.delegate = self
        
        schoolNumberText.translatesAutoresizingMaskIntoConstraints = false
        schoolNumberText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        schoolNumberText.adjustsFontSizeToFitWidth = true
        schoolNumberText.textAlignment = .center
        schoolNumberText.layer.borderWidth = 3
        schoolNumberText.layer.cornerRadius = 7.0
        schoolNumberText.textColor = .white
        schoolNumberText.delegate = self
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.setTitle("Find", for: .normal)
        enterButton.configuration = .filled()
        enterButton.configuration?.baseBackgroundColor = .black
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(searchSATScoresHeaderView)
        view.addSubview(schoolsTableView)
        
        searchSATScoresHeaderView.scoreStackView.addSubview(mathScoreText)
        searchSATScoresHeaderView.numberStackView.addSubview(schoolNumberText)
        searchSATScoresHeaderView.filterStackView.addSubview(errorLabel)
        searchSATScoresHeaderView.filterStackView.addSubview(enterButton)

        NSLayoutConstraint.activate([
            searchSATScoresHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchSATScoresHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            searchSATScoresHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchSATScoresHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: searchSATScoresHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mathScoreText.topAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.topAnchor),
            mathScoreText.rightAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.rightAnchor),
            mathScoreText.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.heightAnchor),
            mathScoreText.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.widthAnchor, multiplier: 0.45),
            
            schoolNumberText.topAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.topAnchor),
            schoolNumberText.rightAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.rightAnchor),
            schoolNumberText.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.heightAnchor),
            schoolNumberText.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.widthAnchor, multiplier: 0.45),
            
            errorLabel.topAnchor.constraint(equalTo: mathScoreText.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.heightAnchor, multiplier: 0.2),
            errorLabel.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.widthAnchor, multiplier: 0.9),
            errorLabel.centerXAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.centerXAnchor),
            
            enterButton.bottomAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.bottomAnchor),
            enterButton.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.heightAnchor, multiplier: 0.5),
            enterButton.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.widthAnchor),
            enterButton.centerXAnchor.constraint(equalTo: searchSATScoresHeaderView.filterStackView.centerXAnchor),
        ])
    }
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
    }
}

extension SearchMathScoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mathScoreText.endEditing(true)
        errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}

extension SearchMathScoreViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if mathScoreText.text!.isEmpty {
            errorHandler(message: "Insert A Value")
            return
        }
        
        if Int(mathScoreText.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(mathScoreText.text!)! < 200 || Int(mathScoreText.text!)! > 800 {
            errorHandler(message: "Please Type In Values Between 200 And 800")
            return
        }
        
        if Int(mathScoreText.text!) != nil {
            searchSATScoreViewModel.myTotalScore = Int(mathScoreText.text!)!
            searchSATScoreViewModel.number = Int(schoolNumberText.text!) ?? 10
            searchSATScoreViewModel.searchMathScores()
            searchSATScoreViewModel.getSearchedSchools()
            schoolsTableView.reloadData()
        }

        func errorHandler(message: String){
             errorLabel.isHidden = false
             errorLabel.text = message
        }
    }
}

extension SearchMathScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: searchSATScoreViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoroLabel.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoroLabel.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSATScoreViewModel.calculatedSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension SearchMathScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.present(SchoolTabBarViewController(school: searchSATScoreViewModel.calculatedSchools[indexPath.row], scores: searchSATScoreViewModel.calculatedSchoolsScores[indexPath.row]), animated: true)
    }
}
