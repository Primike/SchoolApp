//
//  SchoolsCalculatorViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class SchoolsCalculatorViewController: UIViewController {
    let satMathScore = UITextField()
    let satWritingScore = UITextField()
    let satReadingScore = UITextField()
    let errorLabel = UILabel()
    let calculatorButton = UIButton(type: .system)
    let schoolData: [School]
    let schoolSATData: [SchoolScores]
    
    required init(schoolData: [School], schoolSATData: [SchoolScores]) {
        self.schoolData = schoolData
        self.schoolSATData = schoolSATData
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        style()
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
        
        satMathScore.translatesAutoresizingMaskIntoConstraints = false
        satMathScore.placeholder = "Math Score"
        satMathScore.textAlignment = .center
        satMathScore.layer.borderWidth = 1
        satMathScore.layer.cornerRadius = 4.0
//        satMathScore.keyboardType = .numberPad
        satMathScore.delegate = self
        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.placeholder = "Writing Score"
        satWritingScore.textAlignment = .center
        satWritingScore.layer.borderWidth = 1
        satWritingScore.layer.cornerRadius = 4.0
//        satWritingScore.keyboardType = .numberPad
        satWritingScore.delegate = self
        
        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.placeholder = "Reading Score"
        satReadingScore.textAlignment = .center
        satReadingScore.layer.borderWidth = 1
        satReadingScore.layer.cornerRadius = 4.0
//        satReadingScore.keyboardType = .numberPad
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
    
    func layout() {
        view.addSubview(satMathScore)
        view.addSubview(satWritingScore)
        view.addSubview(satReadingScore)
        view.addSubview(errorLabel)
        view.addSubview(calculatorButton)
        
        NSLayoutConstraint.activate([
            satMathScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            satWritingScore.topAnchor.constraint(equalTo: satMathScore.bottomAnchor),
            satReadingScore.topAnchor.constraint(equalTo: satWritingScore.bottomAnchor),
            errorLabel.topAnchor.constraint(equalTo: satReadingScore.bottomAnchor),
            calculatorButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
        ])
    }
    
    @objc func calculatorButtonTapped(sender: UIButton) {
        errorLabel.isHidden = true

        if satMathScore.text!.isEmpty || satWritingScore.text!.isEmpty || satReadingScore.text!.isEmpty {
            errorHandler(message: "Missing SAT Section")
            return
        }
        
        if Int(satMathScore.text!) != nil && Int(satMathScore.text!) != nil && Int(satMathScore.text!) != nil  {
            let x = Int(satMathScore.text!)! + Int(satMathScore.text!)! + Int(satMathScore.text!)!
            print("Sum \(x)")
            navigationController?.pushViewController(CalculatedSchoolsViewController(viewModel: SchoolsCalculatorViewModel(schoolsSATData: schoolSATData, schoolsData: schoolData, myTotalScore: x)), animated: true)
        } else {
            errorHandler(message: "Enter A Numerical Value")
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

    }

}
