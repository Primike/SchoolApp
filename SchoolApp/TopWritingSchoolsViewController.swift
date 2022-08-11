//
//  TopWritingSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class TopWritingSchoolsViewController: UIViewController {
    
    let topSchoolsHeaderView = TopSchoolsHeaderView()
    let schoolsTableView = UITableView()
    let numberOfSchoolsText = UITextField()
    let errorLabel = UILabel()
    let enterButton = UIButton()
    
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
        topSchoolsHeaderView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        topSchoolsHeaderView.backgroundColor = UIColor.systemMint
        
        topSchoolsHeaderView.topSchoolsLabel.text = "Top Schools By SAT Writing Scores"
        
        numberOfSchoolsText.translatesAutoresizingMaskIntoConstraints = false
        numberOfSchoolsText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        numberOfSchoolsText.adjustsFontSizeToFitWidth = true
        numberOfSchoolsText.textAlignment = .center
        numberOfSchoolsText.layer.borderWidth = 3
        numberOfSchoolsText.layer.cornerRadius = 7.0
        numberOfSchoolsText.textColor = .black
        numberOfSchoolsText.delegate = self
        numberOfSchoolsText.backgroundColor = .white

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.imagePlacement = .leading
        config.imagePadding = 5.0
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.configuration = config
        enterButton.configuration?.title = "Search"
        enterButton.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/19)
        enterButton.configuration?.image = UIImage(systemName: "magnifyingglass",
                                                         withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/22)!))
        
        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
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
        schoolCell.configure(info: topSchoolsViewModel.getInfo(for: indexPath))
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
