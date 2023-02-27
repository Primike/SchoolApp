//
//  TopWritingSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class TopWritingSchoolsViewController: UIViewController {
    
    lazy var topSchoolsHeaderView: TopSchoolsHeaderView = {
        var view = TopSchoolsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.backgroundColor = UIColor.systemMint
        view.topSchoolsLabel.text = "Top Schools By SAT Writing Scores"
        return view
    }()

    lazy var schoolsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    lazy var numberOfSchoolsText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        textField.delegate = self
        return textField
    }()

    lazy var errorLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .systemRed)
        label.isHidden = true
        return label
    }()

    lazy var enterButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Search", viewWidth: view.bounds.width, imageName: "magnifyingglass", titleSize: 19, imageSize: 22)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
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
        
        view.backgroundColor = .white

        layout()
    }
    
    func layout() {
        view.addSubview(topSchoolsHeaderView)
        view.addSubview(schoolsTableView)
        
        topSchoolsHeaderView.filterStackView.addSubview(numberOfSchoolsText)
        topSchoolsHeaderView.addSubview(errorLabel)
        topSchoolsHeaderView.addSubview(enterButton)

        NSLayoutConstraint.activate([
            topSchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            topSchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            numberOfSchoolsText.topAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.topAnchor),
            numberOfSchoolsText.heightAnchor.constraint(equalTo: topSchoolsHeaderView.headerStackView.heightAnchor, multiplier: 0.3),
            numberOfSchoolsText.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor, multiplier: 0.3),
            numberOfSchoolsText.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: topSchoolsHeaderView.headerStackView.heightAnchor, multiplier: 0.2),
            errorLabel.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor, multiplier: 0.9),
            errorLabel.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            enterButton.bottomAnchor.constraint(equalTo: topSchoolsHeaderView.headerStackView.bottomAnchor),
            enterButton.heightAnchor.constraint(equalTo: topSchoolsHeaderView.headerStackView.heightAnchor, multiplier: 0.5),
            enterButton.widthAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.widthAnchor),
            enterButton.centerXAnchor.constraint(equalTo: topSchoolsHeaderView.filterStackView.centerXAnchor),
            
            schoolsTableView.topAnchor.constraint(equalTo: topSchoolsHeaderView.bottomAnchor),
            schoolsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            schoolsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension TopWritingSchoolsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numberOfSchoolsText.endEditing(true)
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

extension TopWritingSchoolsViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if numberOfSchoolsText.text!.isEmpty {
            topSchoolsViewModel.number = 10
            topSchoolsViewModel.getTopWritingSchools()
            schoolsTableView.reloadData()
            return
        }
        
        if Int(numberOfSchoolsText.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(numberOfSchoolsText.text!)! < 0 || Int(numberOfSchoolsText.text!)! > topSchoolsViewModel.schoolsScores.count {
            errorHandler(message: "Please Type In Values Between 0 And \(topSchoolsViewModel.schoolsScores.count)")
            return
        }
        
        if Int(numberOfSchoolsText.text!) != nil {
            
            topSchoolsViewModel.number = Int(numberOfSchoolsText.text!)!
            topSchoolsViewModel.getTopWritingSchools()
            schoolsTableView.reloadData()
        }

        func errorHandler(message: String){
             errorLabel.isHidden = false
             errorLabel.text = message
        }
    }
}

extension TopWritingSchoolsViewController: UITableViewDataSource {
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
}

extension TopWritingSchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.present(SchoolTabBarViewController(school: topSchoolsViewModel.topSchools[indexPath.row], scores: topSchoolsViewModel.topSchoolsScores[indexPath.row]), animated: true)
    }
}
