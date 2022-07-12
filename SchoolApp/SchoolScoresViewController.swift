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
    
    let sectionsSubview = UIStackView()
    
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
        
        
        scoresHeaderView.translatesAutoresizingMaskIntoConstraints = false
        scoresHeaderView.backgroundColor = schoolColor
        
        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
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
        scoresLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        scoresLabel.text = "SAT Scores"
        scoresLabel.textColor = .white
        scoresLabel.adjustsFontSizeToFitWidth = true
        
        testTakersLabel.translatesAutoresizingMaskIntoConstraints = false
        testTakersLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        testTakersLabel.text = "Number of test takers: \(schoolScores.num_of_sat_test_takers)"
        testTakersLabel.textColor = .white
        testTakersLabel.numberOfLines = 0
        testTakersLabel.adjustsFontSizeToFitWidth = true
        
        graphButton.translatesAutoresizingMaskIntoConstraints = false
        graphButton.setTitle("Scores Graph", for:.normal)
        graphButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        graphButton.configuration = .filled()
        graphButton.tintColor = .white
        graphButton.setTitleColor(.black, for: .normal)
                
        
        
        
        sectionsSubview.translatesAutoresizingMaskIntoConstraints = false
        sectionsSubview.axis = .vertical
        
        satMathSubView.translatesAutoresizingMaskIntoConstraints = false
        satMathStackView.translatesAutoresizingMaskIntoConstraints = false
        satMathStackView.backgroundColor = schoolColor
        satMathStackView.layer.cornerRadius = 25
        
        satMathLabel.translatesAutoresizingMaskIntoConstraints = false
        satMathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        satMathLabel.text = testNames[0]
        satMathLabel.textColor = .white
        satMathLabel.adjustsFontSizeToFitWidth = true
        satMathLabel.textAlignment = .center
        
        satMathScore.translatesAutoresizingMaskIntoConstraints = false
        satMathScore.font = UIFont(name:"HelveticaNeue", size: 100.0)
        satMathScore.text = "\(schoolScores.sat_math_avg_score)/800"
        satMathScore.textColor = .white
        satMathScore.adjustsFontSizeToFitWidth = true
        satMathScore.textAlignment = .center

        
        satWritingSubView.translatesAutoresizingMaskIntoConstraints = false
        satWritingStackView.translatesAutoresizingMaskIntoConstraints = false
        satWritingStackView.backgroundColor = schoolColor
        satWritingStackView.layer.cornerRadius = 25

        satWritingLabel.translatesAutoresizingMaskIntoConstraints = false
        satWritingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satWritingLabel.text = testNames[1]
        satWritingLabel.textColor = .white
        satWritingLabel.adjustsFontSizeToFitWidth = true
        satWritingLabel.textAlignment = .center

        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        satWritingScore.text = "\(schoolScores.sat_writing_avg_score)/800"
        satWritingScore.textColor = .white
        satWritingScore.adjustsFontSizeToFitWidth = true
        satWritingScore.textAlignment = .center
        
        
        satReadingSubView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.backgroundColor = schoolColor
        satReadingStackView.layer.cornerRadius = 25

        satReadingLabel.translatesAutoresizingMaskIntoConstraints = false
        satReadingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        satReadingLabel.text = testNames[2]
        satReadingLabel.textColor = .white
        satReadingLabel.adjustsFontSizeToFitWidth = true
        satReadingLabel.textAlignment = .center

        
        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        satReadingScore.text = "\(schoolScores.sat_critical_reading_avg_score)/800"
        satReadingScore.textColor = .white
        satReadingScore.adjustsFontSizeToFitWidth = true
        satReadingScore.textAlignment = .center

    }
    
    func layout() {
        
        scrollView.addSubview(screenStackView)

        screenStackView.addArrangedSubview(scoresHeaderView)
        screenStackView.addArrangedSubview(sectionsSubview)
        
        scoresHeaderView.addSubview(schoolName)
        scoresHeaderView.addSubview(scoresHeaderStackView)
        scoresHeaderStackView.addSubview(collegeBoardImage)
        scoresHeaderStackView.addSubview(scoresInfoStackView)
        scoresInfoStackView.addSubview(scoresLabel)
        scoresInfoStackView.addSubview(testTakersLabel)
        scoresInfoStackView.addSubview(graphButton)
        
        sectionsSubview.addSubview(satMathSubView)
        sectionsSubview.addSubview(satWritingSubView)
        sectionsSubview.addSubview(satReadingSubView)
        
        satMathSubView.addSubview(satMathStackView)
        satMathStackView.addSubview(satMathLabel)
        satMathStackView.addSubview(satMathScore)
        
        satWritingSubView.addSubview(satWritingStackView)
        satWritingStackView.addSubview(satWritingLabel)
        satWritingStackView.addSubview(satWritingScore)
        
        satReadingSubView.addSubview(satReadingStackView)
        satReadingStackView.addSubview(satReadingLabel)
        satReadingStackView.addSubview(satReadingScore)

        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
            
        
            
            scoresHeaderView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            scoresHeaderView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            scoresHeaderView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            
            
            schoolName.topAnchor.constraint(equalTo: scoresHeaderView.topAnchor),
            schoolName.widthAnchor.constraint(equalTo: scoresHeaderView.widthAnchor, multiplier: 0.9),
            schoolName.centerXAnchor.constraint(equalTo: scoresHeaderView.centerXAnchor),
            schoolName.heightAnchor.constraint(equalTo: scoresHeaderView.heightAnchor, multiplier: 0.1),
            
            
            scoresHeaderStackView.widthAnchor.constraint(equalTo: scoresHeaderView.widthAnchor, multiplier: 0.8),
            scoresHeaderStackView.heightAnchor.constraint(equalTo: scoresHeaderView.heightAnchor, multiplier: 0.85),
            scoresHeaderStackView.centerXAnchor.constraint(equalTo: scoresHeaderView.centerXAnchor),
            scoresHeaderStackView.topAnchor.constraint(equalTo: schoolName.bottomAnchor, constant: 5),
            
            collegeBoardImage.centerYAnchor.constraint(equalTo: scoresHeaderStackView.centerYAnchor),
            collegeBoardImage.heightAnchor.constraint(equalTo: scoresHeaderStackView.heightAnchor, multiplier: 0.9),
            collegeBoardImage.widthAnchor.constraint(equalTo: scoresHeaderStackView.widthAnchor, multiplier: 0.4),
            collegeBoardImage.leftAnchor.constraint(equalTo: scoresHeaderStackView.leftAnchor),
            
            scoresInfoStackView.rightAnchor.constraint(equalTo: scoresHeaderStackView.rightAnchor),
            scoresInfoStackView.widthAnchor.constraint(equalTo: scoresHeaderStackView.widthAnchor, multiplier: 0.5),
            scoresInfoStackView.heightAnchor.constraint(equalTo: scoresHeaderStackView.heightAnchor, multiplier: 0.9),
            scoresInfoStackView.centerYAnchor.constraint(equalTo: scoresHeaderStackView.centerYAnchor),
            
            scoresLabel.topAnchor.constraint(equalTo: scoresInfoStackView.topAnchor),
            scoresLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),
            scoresLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            scoresLabel.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.3),
            testTakersLabel.topAnchor.constraint(equalTo: scoresLabel.bottomAnchor),
            testTakersLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),
            testTakersLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            testTakersLabel.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.3),
            graphButton.bottomAnchor.constraint(equalTo: scoresInfoStackView.bottomAnchor),
            graphButton.leftAnchor.constraint(equalTo: scoresInfoStackView.leftAnchor),
            graphButton.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            graphButton.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.3),
            
            
            
            
            sectionsSubview.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            sectionsSubview.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.7),
            sectionsSubview.topAnchor.constraint(equalTo: scoresHeaderView.bottomAnchor),

            satMathSubView.topAnchor.constraint(equalTo: sectionsSubview.topAnchor),
            satMathSubView.widthAnchor.constraint(equalTo: sectionsSubview.widthAnchor),
            satMathSubView.heightAnchor.constraint(equalTo: sectionsSubview.heightAnchor, multiplier: 0.3),
            satMathStackView.heightAnchor.constraint(equalTo: satMathSubView.heightAnchor, multiplier: 0.8),
            satMathStackView.widthAnchor.constraint(equalTo: satMathSubView.widthAnchor, multiplier: 0.8),
            satMathStackView.centerXAnchor.constraint(equalTo: satMathSubView.centerXAnchor),
            satMathStackView.centerYAnchor.constraint(equalTo: satMathSubView.centerYAnchor),
            satMathLabel.topAnchor.constraint(equalTo: satMathStackView.topAnchor),
            satMathLabel.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            satMathLabel.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.9),
            satMathLabel.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.4),
            satMathScore.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor),
            satMathScore.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            satMathScore.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.8),
            satMathScore.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.3),

            satWritingSubView.widthAnchor.constraint(equalTo: sectionsSubview.widthAnchor),
            satWritingSubView.heightAnchor.constraint(equalTo: sectionsSubview.heightAnchor, multiplier: 0.3),
            satWritingSubView.centerYAnchor.constraint(equalTo: sectionsSubview.centerYAnchor),
            satWritingStackView.heightAnchor.constraint(equalTo: satWritingSubView.heightAnchor, multiplier: 0.8),
            satWritingStackView.widthAnchor.constraint(equalTo: satWritingSubView.widthAnchor, multiplier: 0.8),
            satWritingStackView.centerXAnchor.constraint(equalTo: satWritingSubView.centerXAnchor),
            satWritingStackView.centerYAnchor.constraint(equalTo: satWritingSubView.centerYAnchor),
            satWritingLabel.topAnchor.constraint(equalTo: satWritingStackView.topAnchor),
            satWritingLabel.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingLabel.widthAnchor.constraint(equalTo: satWritingStackView.widthAnchor, multiplier: 0.9),
            satWritingScore.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor),
            satWritingScore.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),

            satReadingSubView.widthAnchor.constraint(equalTo: sectionsSubview.widthAnchor),
            satReadingSubView.heightAnchor.constraint(equalTo: sectionsSubview.heightAnchor, multiplier: 0.3),
            satReadingSubView.bottomAnchor.constraint(equalTo: sectionsSubview.bottomAnchor),
            satReadingStackView.heightAnchor.constraint(equalTo: satReadingSubView.heightAnchor, multiplier: 0.8),
            satReadingStackView.widthAnchor.constraint(equalTo: satReadingSubView.widthAnchor, multiplier: 0.8),
            satReadingStackView.centerXAnchor.constraint(equalTo: satReadingSubView.centerXAnchor),
            satReadingStackView.centerYAnchor.constraint(equalTo: satReadingSubView.centerYAnchor),
            satReadingLabel.topAnchor.constraint(equalTo: satReadingStackView.topAnchor),
            satReadingLabel.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            satReadingLabel.widthAnchor.constraint(equalTo: satReadingStackView.widthAnchor, multiplier: 0.9),
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

//satMathSubView.topAnchor.constraint(equalTo: sectionsSubview.topAnchor),
//satMathSubView.widthAnchor.constraint(equalTo: sectionsSubview.widthAnchor),
//satMathSubView.heightAnchor.constraint(equalTo: sectionsSubview.heightAnchor, multiplier: 0.3),
//satMathStackView.heightAnchor.constraint(equalTo: satMathSubView.heightAnchor, multiplier: 0.8),
//satMathStackView.widthAnchor.constraint(equalTo: satMathSubView.widthAnchor, multiplier: 0.8),
//satMathStackView.centerXAnchor.constraint(equalTo: satMathSubView.centerXAnchor),
//satMathStackView.centerYAnchor.constraint(equalTo: satMathSubView.centerYAnchor),
//satMathLabel.topAnchor.constraint(equalTo: satMathStackView.topAnchor),
//satMathLabel.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
//satMathLabel.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.9),
//satMathLabel.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.4),
//satMathScore.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor),
//satMathScore.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
//satMathScore.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.8),
//satMathScore.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.3),
