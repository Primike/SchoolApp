//
//  TopReadingSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class TopReadingSchoolsViewController: UIViewController {
    
    let schoolsTableView = UITableView()
    let numberOfSchools = UITextField()
    let errorLabel = UILabel()
    let enterButton = UIButton()
    
    let topSchoolsHeaderView = TopSchoolsHeaderView()
    
    let topSchoolsViewModel: TopSchoolsViewModel
    
    required init(viewModel: TopSchoolsViewModel) {
        self.topSchoolsViewModel = viewModel

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
        topSchoolsHeaderView.backgroundColor = UIColor.systemRed
        
        topSchoolsHeaderView.topSchoolsLabel.text = "Top Schools By SAT Reading Scores"
        
        numberOfSchools.translatesAutoresizingMaskIntoConstraints = false
        numberOfSchools.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        numberOfSchools.font = UIFont(name:"HelveticaNeue", size: 20.0)
        numberOfSchools.adjustsFontSizeToFitWidth = true
        numberOfSchools.textAlignment = .center
        numberOfSchools.layer.borderWidth = 3
        numberOfSchools.layer.cornerRadius = 7.0
        numberOfSchools.textColor = .white
        numberOfSchools.delegate = self
        
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
        
        topSchoolsHeaderView.filterStackView.addSubview(numberOfSchools)
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
            
            numberOfSchools.topAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.topAnchor),
            numberOfSchools.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor, multiplier: 0.3),
            numberOfSchools.heightAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.heightAnchor, multiplier: 0.3),
            numberOfSchools.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: numberOfSchools.bottomAnchor),
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

extension TopReadingSchoolsViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numberOfSchools.endEditing(true)
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

extension TopReadingSchoolsViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if numberOfSchools.text!.isEmpty {
            topSchoolsViewModel.number = 10
            topSchoolsViewModel.getTopReadingSchools()
            schoolsTableView.reloadData()
            return
        }
        
        if Int(numberOfSchools.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(numberOfSchools.text!)! < 0 || Int(numberOfSchools.text!)! > topSchoolsViewModel.schoolsScores.count {
            errorHandler(message: "Please Type In Values Between 0 And \(topSchoolsViewModel.schoolsScores.count)")
            return
        }
        
        if Int(numberOfSchools.text!) != nil {
            
            topSchoolsViewModel.number = Int(numberOfSchools.text!)!
            topSchoolsViewModel.getTopReadingSchools()
            schoolsTableView.reloadData()
        }

        func errorHandler(message: String){
             errorLabel.isHidden = false
             errorLabel.text = message
        }
    }
}

extension TopReadingSchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: topSchoolsViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoro.text = "Rank #\(indexPath.row + 1)"
        schoolCell.schoolBoro.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSchoolsViewModel.topSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}



extension TopReadingSchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(SchoolTabBarViewController(school: topSchoolsViewModel.topSchools[indexPath.row], scores: topSchoolsViewModel.topSchoolsScores[indexPath.row]), animated: true)
    }
}
