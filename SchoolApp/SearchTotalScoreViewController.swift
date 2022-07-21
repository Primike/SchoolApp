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
    let totalScore = UITextField()
    let errorLabel = UILabel()
    let enterButton = UIButton()
    
    let topSchoolsHeaderView = TopSchoolsHeaderView()
    
    let searchSATScoreViewModel: SearchSATScoreViewModel
    
    required init(viewModel: SearchSATScoreViewModel) {
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
        
        topSchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsHeaderView.layer.cornerRadius = 30
        topSchoolsHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topSchoolsHeaderView.backgroundColor = UIColor.systemBlue
        
        totalScore.translatesAutoresizingMaskIntoConstraints = false
        totalScore.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        totalScore.font = UIFont(name:"HelveticaNeue", size: 20.0)
        totalScore.adjustsFontSizeToFitWidth = true
        totalScore.textAlignment = .center
        totalScore.layer.borderWidth = 3
        totalScore.layer.cornerRadius = 7.0
        totalScore.textColor = .white
        totalScore.delegate = self
        
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
        view.addSubview(topSchoolsHeaderView)
        view.addSubview(schoolsTableView)
        
        topSchoolsHeaderView.filterStackView.addSubview(totalScore)
        topSchoolsHeaderView.filterStackView.addSubview(errorLabel)
        topSchoolsHeaderView.filterStackView.addSubview(enterButton)

        NSLayoutConstraint.activate([
            topSchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topSchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),
            
            schoolsTableView.topAnchor.constraint(equalTo: topSchoolsHeaderView.bottomAnchor),
            schoolsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalScore.topAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.topAnchor),
            totalScore.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor, multiplier: 0.3),
            totalScore.heightAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.heightAnchor, multiplier: 0.3),
            totalScore.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: totalScore.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.heightAnchor, multiplier: 0.2),
            errorLabel.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor, multiplier: 0.9),
            errorLabel.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            enterButton.bottomAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.bottomAnchor),
            enterButton.heightAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.heightAnchor, multiplier: 0.5),
            enterButton.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor),
            enterButton.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
        ])
    }
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
    }
}

extension SearchTotalScoreViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        totalScore.endEditing(true)
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

        if totalScore.text!.isEmpty {
            errorHandler(message: "Insert A Value")
            return
        }
        
        if Int(totalScore.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(totalScore.text!)! < 600 || Int(totalScore.text!)! > 2400 {
            errorHandler(message: "Please Type In Values Between 600 And 2400")
            return
        }
        
        if Int(totalScore.text!) != nil {
            
            searchSATScoreViewModel.myTotalScore = Int(totalScore.text!)!
            searchSATScoreViewModel.calculateSATList()
            searchSATScoreViewModel.getCalculatedSchools()
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
        schoolCell.schoolBoro.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoro.textColor = .black
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

        navigationController?.pushViewController(SchoolTabBarViewController(school: searchSATScoreViewModel.calculatedSchools[indexPath.row], scores: searchSATScoreViewModel.calculatedSchoolsScores[indexPath.row]), animated: true)
    }
}
