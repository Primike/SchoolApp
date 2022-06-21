//
//  TestsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class TestsViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let satMainView = UIView()
    let satHeaderStackView = UIStackView()
    let satImage = UIImageView(image: UIImage(named: "satheader"))
    let satInfoStackView = UIStackView()
    let satLabel = UILabel()
    let satTestTakers = UILabel()
    
    let satMathSubView = UIView()
    let satMathStackView = UIStackView()
    let satMathLabel = UILabel()
    let satMathScore = UILabel()

    let satWritingSubView = UIView()
    let satWritingStackView = UIStackView()
    let satWritingLabel = UILabel()
    let satWritingScore = UILabel()
    
    let satReadingSubView = UIView()
    let satReadingStackView = UIStackView()
    let satReadingLabel = UILabel()
    let satReadingScore = UILabel()
    
    let presentButton = UIButton(type: .system)
    
    var school: School
    var tests: SchoolScore
    let testNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]
    
    init(school: School, tests: SchoolScore) {
        self.school = school
        self.tests = tests
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "schoolbackground") ?? UIImage())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        
        
        
        
        satMainView.translatesAutoresizingMaskIntoConstraints = false
        satMainView.backgroundColor = UIColor.systemBlue
        satMainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        satMainView.layer.cornerRadius = 30
        
        satHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        satHeaderStackView.axis = .horizontal

        satImage.translatesAutoresizingMaskIntoConstraints = false
        satImage.contentMode = .scaleAspectFit
        
        satInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        satLabel.translatesAutoresizingMaskIntoConstraints = false
        satLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        satLabel.text = "SAT Scores"
        satLabel.textColor = .white
        
        satTestTakers.translatesAutoresizingMaskIntoConstraints = false
        satTestTakers.font = UIFont(name:"HelveticaNeue", size: 20.0)
        satTestTakers.text = "Number of test takers: \(tests.num_of_sat_test_takers)"
        satTestTakers.textColor = .white
        satTestTakers.numberOfLines = 0
        
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.setTitle("Show Scores Graph", for: [])
        presentButton.addTarget(self, action: #selector(presentButtonTapped), for: .primaryActionTriggered)
        presentButton.backgroundColor = UIColor.black
        presentButton.setTitleColor(.white, for: .normal)
        
        
        
        
        satMathSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satMathStackView.translatesAutoresizingMaskIntoConstraints = false
        satMathStackView.backgroundColor = UIColor.systemGreen
        satMathStackView.layer.cornerRadius = 25
        satMathStackView.layer.borderWidth = 4
        satMathStackView.layer.borderColor = UIColor.black.cgColor
        
        satMathLabel.translatesAutoresizingMaskIntoConstraints = false
        satMathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satMathLabel.text = testNames[0]
        satMathLabel.textColor = .black
        
        satMathScore.translatesAutoresizingMaskIntoConstraints = false
        satMathScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satMathScore.text = "\(tests.sat_math_avg_score)/800"
        satMathScore.textColor = .black

        
        
        
        satWritingSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satWritingStackView.translatesAutoresizingMaskIntoConstraints = false
        satWritingStackView.backgroundColor = UIColor.systemRed
        satWritingStackView.layer.cornerRadius = 25
        satWritingStackView.layer.borderWidth = 4
        satWritingStackView.layer.borderColor = UIColor.black.cgColor

        satWritingLabel.translatesAutoresizingMaskIntoConstraints = false
        satWritingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satWritingLabel.text = testNames[1]
        satWritingLabel.textColor = .black
        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satWritingScore.text = "\(tests.sat_writing_avg_score)/800"
        satWritingScore.textColor = .black
        
        
        
        satReadingSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satReadingStackView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.backgroundColor = UIColor.systemCyan
        satReadingStackView.layer.cornerRadius = 25
        satReadingStackView.layer.borderWidth = 4
        satReadingStackView.layer.borderColor = UIColor.black.cgColor

        satReadingLabel.translatesAutoresizingMaskIntoConstraints = false
        satReadingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satReadingLabel.text = testNames[2]
        satReadingLabel.textColor = .black
        
        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satReadingScore.text = "\(tests.sat_critical_reading_avg_score)/800"
        satReadingScore.textColor = .black
        
    }
    
    func layout() {
        
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(satMainView)
        stackView.addArrangedSubview(satMathSubView)
        stackView.addArrangedSubview(satWritingSubView)
        stackView.addArrangedSubview(satReadingSubView)
        
        satMainView.addSubview(satHeaderStackView)
        satMathSubView.addSubview(satMathStackView)
        satWritingSubView.addSubview(satWritingStackView)
        satReadingSubView.addSubview(satReadingStackView)
        
        satHeaderStackView.addSubview(satInfoStackView)
        satHeaderStackView.addSubview(satImage)
        
        satInfoStackView.addSubview(satLabel)
        satInfoStackView.addSubview(satTestTakers)
        satInfoStackView.addSubview(presentButton)
        satMathStackView.addSubview(satMathLabel)
        satMathStackView.addSubview(satMathScore)
        satWritingStackView.addSubview(satWritingLabel)
        satWritingStackView.addSubview(satWritingScore)
        satReadingStackView.addSubview(satReadingLabel)
        satReadingStackView.addSubview(satReadingScore)

        
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            
            
//            satMainView.topAnchor.constraint(equalTo: stackView.topAnchor),
            satMainView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            satMainView.heightAnchor.constraint(equalToConstant: 170),
            satHeaderStackView.widthAnchor.constraint(equalTo: satMainView.widthAnchor, multiplier: 0.9),
            satHeaderStackView.heightAnchor.constraint(equalTo: satMainView.heightAnchor, multiplier: 0.9),
            satHeaderStackView.centerXAnchor.constraint(equalTo: satMainView.centerXAnchor),
            satHeaderStackView.centerYAnchor.constraint(equalTo: satMainView.centerYAnchor),
            satImage.topAnchor.constraint(equalTo: satHeaderStackView.topAnchor),
            satImage.heightAnchor.constraint(equalTo: satHeaderStackView.heightAnchor),
            satImage.widthAnchor.constraint(equalTo: satHeaderStackView.widthAnchor, multiplier: 0.5),
            satInfoStackView.leftAnchor.constraint(equalTo: satImage.rightAnchor),
            satInfoStackView.topAnchor.constraint(equalTo: satHeaderStackView.topAnchor),
            satInfoStackView.widthAnchor.constraint(equalTo: satHeaderStackView.widthAnchor, multiplier: 0.5),
            satLabel.topAnchor.constraint(equalTo: satInfoStackView.topAnchor),
            satLabel.centerXAnchor.constraint(equalTo: satInfoStackView.centerXAnchor),
            satLabel.widthAnchor.constraint(equalTo: satInfoStackView.widthAnchor),
            satLabel.heightAnchor.constraint(equalTo: satInfoStackView.heightAnchor, multiplier: 0.25),
            satTestTakers.topAnchor.constraint(equalTo: satLabel.bottomAnchor),
            satTestTakers.centerXAnchor.constraint(equalTo: satInfoStackView.centerXAnchor),
            satTestTakers.widthAnchor.constraint(equalTo: satInfoStackView.widthAnchor),
            satTestTakers.heightAnchor.constraint(equalTo: satInfoStackView.heightAnchor, multiplier: 0.25),
            presentButton.topAnchor.constraint(equalTo: satTestTakers.bottomAnchor, constant: 15),
            presentButton.leftAnchor.constraint(equalTo: satInfoStackView.leftAnchor),
            
            
//            satMathSubView.topAnchor.constraint(equalTo: satMainView.bottomAnchor),
            satMathSubView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            satMathSubView.heightAnchor.constraint(equalToConstant: 100),
            satMathStackView.topAnchor.constraint(equalTo: satMathSubView.topAnchor),
            satMathStackView.widthAnchor.constraint(equalTo: satMathSubView.widthAnchor, multiplier: 0.90),
            satMathStackView.centerXAnchor.constraint(equalTo: satMathSubView.centerXAnchor),
            satMathStackView.bottomAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satMathLabel.topAnchor.constraint(equalTo: satMathStackView.topAnchor),
            satMathLabel.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            satMathScore.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor),
            satMathScore.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            
//            satWritingSubView.topAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satWritingSubView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            satWritingSubView.heightAnchor.constraint(equalToConstant: 100),
            satWritingStackView.topAnchor.constraint(equalTo: satWritingSubView.topAnchor),
            satWritingStackView.widthAnchor.constraint(equalTo: satWritingSubView.widthAnchor, multiplier: 0.9),
            satWritingStackView.centerXAnchor.constraint(equalTo: satWritingSubView.centerXAnchor),
            satWritingStackView.bottomAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satWritingLabel.topAnchor.constraint(equalTo: satWritingStackView.topAnchor),
            satWritingLabel.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingScore.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor),
            satWritingScore.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            
//            satReadingSubView.topAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satReadingSubView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            satReadingSubView.heightAnchor.constraint(equalToConstant: 100),
            satReadingStackView.topAnchor.constraint(equalTo: satReadingSubView.topAnchor),
            satReadingStackView.widthAnchor.constraint(equalTo: satReadingSubView.widthAnchor, multiplier: 0.9),
            satReadingStackView.centerXAnchor.constraint(equalTo: satReadingSubView.centerXAnchor),
            satReadingStackView.bottomAnchor.constraint(equalTo: satReadingSubView.bottomAnchor),
            satReadingLabel.topAnchor.constraint(equalTo: satReadingStackView.topAnchor),
            satReadingLabel.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            satReadingScore.topAnchor.constraint(equalTo: satReadingLabel.bottomAnchor),
            satReadingScore.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            
        ])
    }

}


extension TestsViewController {
    @objc func presentButtonTapped(sender: UIButton) {
        print("QWEQWE")
        navigationController?.present(TestGraphViewController(school: school, tests: tests), animated: true, completion: nil)
    }
}

