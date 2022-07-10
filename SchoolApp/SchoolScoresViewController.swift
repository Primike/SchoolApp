//
//  TestsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolScoresViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let screenStackView = UIStackView()
    
    let scoresHeaderView = UIView()
    
    let schoolName = UILabel()
    
    let scoresHeaderStackView = UIStackView()
    let collegeBoardImage = UIImageView(image: UIImage(named: "satheader"))
    let scoresInfoStackView = UIStackView()
    let scoresLabel = UILabel()
    let testTakersLabel = UILabel()
    
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
    
    let graphButton = UIButton()
    
    let school: School
    let schoolScores: SchoolScores
    let schoolColor: UIColor
    let testNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]
    
    init(school: School, scores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolScores = scores
        self.schoolColor = schoolColor

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
        scrollView.backgroundColor = .systemBackground
        
        screenStackView.translatesAutoresizingMaskIntoConstraints = false
        screenStackView.axis = .vertical
        screenStackView.spacing = 30
        
        
        scoresHeaderView.translatesAutoresizingMaskIntoConstraints = false
        scoresHeaderView.backgroundColor = schoolColor
        
        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        schoolName.text = school.school_name
        schoolName.textColor = .white
        schoolName.textAlignment = .center
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.numberOfLines = 0
    
        
        
        scoresHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        scoresHeaderStackView.axis = .horizontal


        collegeBoardImage.translatesAutoresizingMaskIntoConstraints = false
        collegeBoardImage.contentMode = .scaleAspectFit

        
        scoresInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        scoresLabel.translatesAutoresizingMaskIntoConstraints = false
        scoresLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        scoresLabel.text = "SAT Scores"
        scoresLabel.textColor = .white
        scoresLabel.adjustsFontSizeToFitWidth = true
        
        testTakersLabel.translatesAutoresizingMaskIntoConstraints = false
        testTakersLabel.font = UIFont(name:"HelveticaNeue", size: 20.0)
        testTakersLabel.text = "Number of test takers: \(schoolScores.num_of_sat_test_takers)"
        testTakersLabel.textColor = .white
        testTakersLabel.numberOfLines = 0
        testTakersLabel.adjustsFontSizeToFitWidth = true
        
        graphButton.translatesAutoresizingMaskIntoConstraints = false
        graphButton.setTitle("Show Scores Graph", for: [])
        graphButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        graphButton.configuration = .filled()
        graphButton.tintColor = .white
        graphButton.setTitleColor(.black, for: .normal)

        
        
        
        satMathSubView.translatesAutoresizingMaskIntoConstraints = false
        satMathStackView.translatesAutoresizingMaskIntoConstraints = false
        satMathStackView.backgroundColor = schoolColor
        satMathStackView.layer.cornerRadius = 25
        
        satMathLabel.translatesAutoresizingMaskIntoConstraints = false
        satMathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satMathLabel.text = testNames[0]
        satMathLabel.textColor = .white
        satMathLabel.adjustsFontSizeToFitWidth = true
        
        satMathScore.translatesAutoresizingMaskIntoConstraints = false
        satMathScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satMathScore.text = "\(schoolScores.sat_math_avg_score)/800"
        satMathScore.textColor = .white
        satMathScore.adjustsFontSizeToFitWidth = true

        
        satWritingSubView.translatesAutoresizingMaskIntoConstraints = false
        satWritingStackView.translatesAutoresizingMaskIntoConstraints = false
        satWritingStackView.backgroundColor = schoolColor
        satWritingStackView.layer.cornerRadius = 25

        satWritingLabel.translatesAutoresizingMaskIntoConstraints = false
        satWritingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satWritingLabel.text = testNames[1]
        satWritingLabel.textColor = .white
        satWritingLabel.adjustsFontSizeToFitWidth = true

        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satWritingScore.text = "\(schoolScores.sat_writing_avg_score)/800"
        satWritingScore.textColor = .white
        satWritingScore.adjustsFontSizeToFitWidth = true
        
        
        satReadingSubView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.backgroundColor = schoolColor
        satReadingStackView.layer.cornerRadius = 25

        satReadingLabel.translatesAutoresizingMaskIntoConstraints = false
        satReadingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satReadingLabel.text = testNames[2]
        satReadingLabel.textColor = .white
        satReadingLabel.adjustsFontSizeToFitWidth = true

        
        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satReadingScore.text = "\(schoolScores.sat_critical_reading_avg_score)/800"
        satReadingScore.textColor = .white
        satReadingScore.adjustsFontSizeToFitWidth = true

    }
    
    func layout() {
        
        scrollView.addSubview(screenStackView)

        screenStackView.addArrangedSubview(scoresHeaderView)
        screenStackView.addArrangedSubview(satMathSubView)
        screenStackView.addArrangedSubview(satWritingSubView)
        screenStackView.addArrangedSubview(satReadingSubView)
        
        scoresHeaderView.addSubview(schoolName)
        scoresHeaderView.addSubview(scoresHeaderStackView)
        scoresHeaderStackView.addSubview(scoresInfoStackView)
        scoresHeaderStackView.addSubview(collegeBoardImage)
        scoresInfoStackView.addSubview(scoresLabel)
        scoresInfoStackView.addSubview(testTakersLabel)
        scoresInfoStackView.addSubview(graphButton)
        
        satMathSubView.addSubview(satMathStackView)
        satWritingSubView.addSubview(satWritingStackView)
        satReadingSubView.addSubview(satReadingStackView)
        satMathStackView.addSubview(satMathLabel)
        satMathStackView.addSubview(satMathScore)
        satWritingStackView.addSubview(satWritingLabel)
        satWritingStackView.addSubview(satWritingScore)
        satReadingStackView.addSubview(satReadingLabel)
        satReadingStackView.addSubview(satReadingScore)

        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            screenStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
        
            
            scoresHeaderView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            scoresHeaderView.heightAnchor.constraint(equalToConstant: 250),
            
            
            schoolName.topAnchor.constraint(equalTo: scoresHeaderView.topAnchor),
            schoolName.widthAnchor.constraint(equalTo: scoresHeaderView.widthAnchor, multiplier: 0.9),
            schoolName.centerXAnchor.constraint(equalTo: scoresHeaderView.centerXAnchor),
            schoolName.heightAnchor.constraint(equalTo: scoresHeaderView.heightAnchor, multiplier: 0.15),
            
            
            scoresHeaderStackView.widthAnchor.constraint(equalTo: scoresHeaderView.widthAnchor, multiplier: 0.9),
            scoresHeaderStackView.heightAnchor.constraint(equalTo: scoresHeaderView.heightAnchor, multiplier: 0.8),
            scoresHeaderStackView.centerXAnchor.constraint(equalTo: scoresHeaderView.centerXAnchor),
            scoresHeaderStackView.topAnchor.constraint(equalTo: schoolName.bottomAnchor, constant: 10),
            
            collegeBoardImage.topAnchor.constraint(equalTo: scoresHeaderStackView.topAnchor),
            collegeBoardImage.heightAnchor.constraint(equalTo: scoresHeaderStackView.heightAnchor,multiplier: 0.9),
            collegeBoardImage.widthAnchor.constraint(equalTo: scoresHeaderStackView.widthAnchor, multiplier: 0.5),
            collegeBoardImage.leftAnchor.constraint(equalTo: scoresHeaderStackView.leftAnchor),
            
            scoresInfoStackView.leftAnchor.constraint(equalTo: collegeBoardImage.rightAnchor),
            scoresInfoStackView.topAnchor.constraint(equalTo: scoresHeaderStackView.topAnchor),
            scoresInfoStackView.widthAnchor.constraint(equalTo: scoresHeaderStackView.widthAnchor, multiplier: 0.5),
            scoresInfoStackView.heightAnchor.constraint(equalTo: scoresHeaderStackView.heightAnchor),
            scoresInfoStackView.centerYAnchor.constraint(equalTo: scoresHeaderStackView.centerYAnchor),
            scoresLabel.topAnchor.constraint(equalTo: scoresInfoStackView.topAnchor),
            scoresLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),
            scoresLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            scoresLabel.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.25),
            testTakersLabel.topAnchor.constraint(equalTo: scoresLabel.bottomAnchor),
            testTakersLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),
            testTakersLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            graphButton.topAnchor.constraint(equalTo: testTakersLabel.bottomAnchor, constant: 15),
            graphButton.leftAnchor.constraint(equalTo: scoresInfoStackView.leftAnchor),
            
            
            
            
            satMathSubView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            satMathSubView.heightAnchor.constraint(equalToConstant: 100),
            satMathStackView.topAnchor.constraint(equalTo: satMathSubView.topAnchor),
            satMathStackView.widthAnchor.constraint(equalTo: satMathSubView.widthAnchor, multiplier: 0.90),
            satMathStackView.centerXAnchor.constraint(equalTo: satMathSubView.centerXAnchor),
            satMathStackView.bottomAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satMathLabel.topAnchor.constraint(equalTo: satMathStackView.topAnchor),
            satMathLabel.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            satMathScore.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor),
            satMathScore.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            
            satWritingSubView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            satWritingSubView.heightAnchor.constraint(equalToConstant: 100),
            satWritingStackView.topAnchor.constraint(equalTo: satWritingSubView.topAnchor),
            satWritingStackView.widthAnchor.constraint(equalTo: satWritingSubView.widthAnchor, multiplier: 0.9),
            satWritingStackView.centerXAnchor.constraint(equalTo: satWritingSubView.centerXAnchor),
            satWritingStackView.bottomAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satWritingLabel.topAnchor.constraint(equalTo: satWritingStackView.topAnchor),
            satWritingLabel.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingScore.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor),
            satWritingScore.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            
            satReadingSubView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
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


extension SchoolScoresViewController {
    @objc func graphButtonTapped(sender: UIButton) {
        navigationController?.present(SchoolGraphViewController(school: school, scores: schoolScores, schoolColor: schoolColor), animated: true, completion: nil)
    }
}

