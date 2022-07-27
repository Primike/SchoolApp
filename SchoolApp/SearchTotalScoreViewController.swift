//
//  SearchSATScoreViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchTotalScoreViewController: UIViewController {
    
    let schoolsTableView = UITableView()
    let totalScoreText = UITextField()
    let schoolNumberText = UITextField()
    let errorLabel = UILabel()
    let enterButton = UIButton()
    
    let searchSATScoresHeaderView = SearchScoresHeaderView()
    
    let searchSATScoreViewModel: SearchScoresViewModel
    
    required init(viewModel: SearchScoresViewModel) {
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
        searchSATScoresHeaderView.layer.cornerRadius = 30
        searchSATScoresHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        searchSATScoresHeaderView.backgroundColor = UIColor.systemBlue
        
        totalScoreText.translatesAutoresizingMaskIntoConstraints = false
        totalScoreText.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        totalScoreText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        totalScoreText.adjustsFontSizeToFitWidth = true
        totalScoreText.textAlignment = .center
        totalScoreText.layer.borderWidth = 3
        totalScoreText.layer.cornerRadius = 7.0
        totalScoreText.textColor = .white
        totalScoreText.delegate = self
        
        schoolNumberText.translatesAutoresizingMaskIntoConstraints = false
        schoolNumberText.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        errorLabel.textColor = .systemRed
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.backgroundColor = .black
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitle("Find", for: .normal)
        enterButton.titleLabel!.font = UIFont(name:"HelveticaNeue-bold", size: 25.0)
        enterButton.titleLabel!.adjustsFontSizeToFitWidth = true
        enterButton.layer.cornerRadius = 10
        enterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(searchSATScoresHeaderView)
        view.addSubview(schoolsTableView)
        
        searchSATScoresHeaderView.scoreStackView.addSubview(totalScoreText)
        searchSATScoresHeaderView.numberStackView.addSubview(schoolNumberText)
        searchSATScoresHeaderView.filterStackView.addSubview(errorLabel)
        searchSATScoresHeaderView.filterStackView.addSubview(enterButton)

        NSLayoutConstraint.activate([
            searchSATScoresHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchSATScoresHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchSATScoresHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),
            
            schoolsTableView.topAnchor.constraint(equalTo: searchSATScoresHeaderView.bottomAnchor),
            schoolsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalScoreText.topAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.topAnchor),
            totalScoreText.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.widthAnchor, multiplier: 0.45),
            totalScoreText.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.heightAnchor),
            totalScoreText.rightAnchor.constraint(equalTo: searchSATScoresHeaderView.scoreStackView.rightAnchor),
            
            schoolNumberText.topAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.topAnchor),
            schoolNumberText.widthAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.widthAnchor, multiplier: 0.45),
            schoolNumberText.heightAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.heightAnchor),
            schoolNumberText.rightAnchor.constraint(equalTo: searchSATScoresHeaderView.numberStackView.rightAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: totalScoreText.bottomAnchor),
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

//check if need to add other text to endeditin
extension SearchTotalScoreViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        totalScoreText.endEditing(true)
        errorLabel.isHidden = true
        return true
    }
    
    //callback to see what's in the text field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}

extension SearchTotalScoreViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if totalScoreText.text!.isEmpty {
            errorHandler(message: "Insert A Value")
            return
        }
        
        if Int(totalScoreText.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(totalScoreText.text!)! < 600 || Int(totalScoreText.text!)! > 2400 {
            errorHandler(message: "Please Type In Values Between 600 And 2400")
            return
        }
        
        if Int(totalScoreText.text!) != nil {
            searchSATScoreViewModel.myTotalScore = Int(totalScoreText.text!)!
            searchSATScoreViewModel.number = Int(schoolNumberText.text!) ?? 10
            searchSATScoreViewModel.searchTotalScores()
            searchSATScoreViewModel.getSearchedSchools()
            schoolsTableView.reloadData()
        }

        func errorHandler(message: String){
             errorLabel.isHidden = false
             errorLabel.text = message
        }
    }
}

extension SearchTotalScoreViewController: UITableViewDataSource {
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



extension SearchTotalScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.present(SchoolTabBarViewController(school: searchSATScoreViewModel.calculatedSchools[indexPath.row], scores: searchSATScoreViewModel.calculatedSchoolsScores[indexPath.row]), animated: true)
    }
}
