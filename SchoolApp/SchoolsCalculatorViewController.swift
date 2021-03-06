//
//  SchoolsCalculatorViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class SchoolsCalculatorViewController: UIViewController {
    let topView = UIView()
    let satMathScore = UITextField()
    let satWritingScore = UITextField()
    let satReadingScore = UITextField()
    let errorLabel = UILabel()
    let calculatorButton = UIButton(type: .system)
    let schoolsTableView = UITableView()

    let schoolsCalculatorViewModel: SearchSATScoresViewModel
    
    required init(viewModel: SearchSATScoresViewModel) {
        self.schoolsCalculatorViewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        style()
        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.satMathScore.text = ""
        self.satReadingScore.text = ""
        self.satWritingScore.text = ""

    }
}

extension SchoolsCalculatorViewController {
    func style() {
        view.backgroundColor = .white
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.layer.cornerRadius = 35
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topView.backgroundColor = .systemBlue

        schoolsTableView.translatesAutoresizingMaskIntoConstraints = false

        satMathScore.translatesAutoresizingMaskIntoConstraints = false
        satMathScore.placeholder = "Math Score"
        satMathScore.textAlignment = .center
        satMathScore.layer.borderWidth = 1
        satMathScore.layer.cornerRadius = 4.0
        satMathScore.delegate = self
        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.placeholder = "Writing Score"
        satWritingScore.textAlignment = .center
        satWritingScore.layer.borderWidth = 1
        satWritingScore.layer.cornerRadius = 4.0
        satWritingScore.delegate = self
        
        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.placeholder = "Reading Score"
        satReadingScore.textAlignment = .center
        satReadingScore.layer.borderWidth = 1
        satReadingScore.layer.cornerRadius = 4.0
        satReadingScore.delegate = self
        
        
        calculatorButton.translatesAutoresizingMaskIntoConstraints = false
        calculatorButton.addTarget(self, action: #selector(calculatorButtonTapped), for: .primaryActionTriggered)
        calculatorButton.backgroundColor = .black
        calculatorButton.setTitleColor(.white, for: .normal)
        calculatorButton.setTitle("Calculate", for: .normal)
        calculatorButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        calculatorButton.titleLabel!.adjustsFontSizeToFitWidth = true
        calculatorButton.layer.cornerRadius = 10
        calculatorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
    }
    
    func setup() {
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self
    }
    
    func layout() {
        view.addSubview(topView)
        topView.addSubview(satMathScore)
        topView.addSubview(satWritingScore)
        topView.addSubview(satReadingScore)
        topView.addSubview(errorLabel)
        topView.addSubview(calculatorButton)
        
        view.addSubview(schoolsTableView)
        
        NSLayoutConstraint.activate([
            satMathScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            satWritingScore.topAnchor.constraint(equalTo: satMathScore.bottomAnchor),
            satReadingScore.topAnchor.constraint(equalTo: satWritingScore.bottomAnchor),
            errorLabel.topAnchor.constraint(equalTo: satReadingScore.bottomAnchor),
            calculatorButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            schoolsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            schoolsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

extension SchoolsCalculatorViewController {
    @objc func calculatorButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if satMathScore.text!.isEmpty || satWritingScore.text!.isEmpty || satReadingScore.text!.isEmpty {
            errorHandler(message: "Missing SAT Section")
            return
        }
        
        if Int(satMathScore.text!) == nil || Int(satReadingScore.text!) == nil || Int(satWritingScore.text!) == nil {
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(satMathScore.text!)! < 200 || Int(satMathScore.text!)! > 800 || Int(satReadingScore.text!)! < 200 || Int(satReadingScore.text!)! > 800 || Int(satWritingScore.text!)! < 200 || Int(satWritingScore.text!)! > 800 {
            errorHandler(message: "Please Type In Values Between 200 And 800")
            return
        }
        
        if Int(satMathScore.text!) != nil && Int(satMathScore.text!) != nil && Int(satMathScore.text!) != nil  {
            let x = Int(satMathScore.text!)! + Int(satMathScore.text!)! + Int(satMathScore.text!)!

            schoolsCalculatorViewModel.myTotalScore = x
            schoolsCalculatorViewModel.searchTotalScores()
            schoolsCalculatorViewModel.getSearchedSchools()
            print(schoolsCalculatorViewModel.myTotalScore, schoolsCalculatorViewModel.calculatedSchools.count)
            schoolsTableView.reloadData()
            
        }

        func errorHandler(message: String){
             errorLabel.isHidden = false
             errorLabel.text = message
        }
    }
}

extension SchoolsCalculatorViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        satMathScore.endEditing(true)
        satWritingScore.endEditing(true)
        satReadingScore.endEditing(true)
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

extension SchoolsCalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schoolCell = SchoolTableViewCell()
        schoolCell.configure(info: schoolsCalculatorViewModel.getInfo(for: indexPath))
        schoolCell.schoolBoroLabel.text = "#\(indexPath.row + 1)"
        schoolCell.schoolBoroLabel.textColor = .black
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schoolsCalculatorViewModel.calculatedSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SchoolTabBarViewController(school: schoolsCalculatorViewModel.calculatedSchools[indexPath.row], scores: schoolsCalculatorViewModel.calculatedSchoolsScores[indexPath.row]), animated: true)
    }
    
}
