//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

//make views
class SchoolScoresBottomView: UIView {
    
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
    
    let school: School
    let schoolScores: SchoolScores
    let schoolColor: UIColor
    let testNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]

    init(frame: CGRect, school: School, schoolScores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        self.schoolScores = schoolScores
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
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
        satWritingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        satWritingLabel.text = testNames[1]
        satWritingLabel.textColor = .white
        satWritingLabel.adjustsFontSizeToFitWidth = true
        satWritingLabel.textAlignment = .center
        
        satWritingScore.translatesAutoresizingMaskIntoConstraints = false
        satWritingScore.font = UIFont(name:"HelveticaNeue", size: 100.0)
        satWritingScore.text = "\(schoolScores.sat_writing_avg_score)/800"
        satWritingScore.textColor = .white
        satWritingScore.adjustsFontSizeToFitWidth = true
        satWritingScore.textAlignment = .center
        
        
        satReadingSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satReadingStackView.translatesAutoresizingMaskIntoConstraints = false
        satReadingStackView.backgroundColor = schoolColor
        satReadingStackView.layer.cornerRadius = 25

        satReadingLabel.translatesAutoresizingMaskIntoConstraints = false
        satReadingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        satReadingLabel.text = testNames[2]
        satReadingLabel.textColor = .white
        satReadingLabel.adjustsFontSizeToFitWidth = true
        satReadingLabel.textAlignment = .center

        satReadingScore.translatesAutoresizingMaskIntoConstraints = false
        satReadingScore.font = UIFont(name:"HelveticaNeue", size: 100.0)
        satReadingScore.text = "\(schoolScores.sat_critical_reading_avg_score)/800"
        satReadingScore.textColor = .white
        satReadingScore.adjustsFontSizeToFitWidth = true
        satReadingScore.textAlignment = .center
    }
    
    func layout() {
        self.addSubview(satMathSubView)
        self.addSubview(satWritingSubView)
        self.addSubview(satReadingSubView)
        
        satMathSubView.addSubview(satMathStackView)
        satMathStackView.addSubview(satMathLabel)
        satMathStackView.addSubview(satMathScore)
        
        satWritingSubView.addSubview(satWritingStackView)
        satWritingStackView.addSubview(satWritingLabel)
        satWritingStackView.addSubview(satWritingScore)
        
        satReadingSubView.addSubview(satReadingStackView)
        satReadingStackView.addSubview(satReadingLabel)
        satReadingStackView.addSubview(satReadingScore)
        
        NSLayoutConstraint.activate([
            satMathSubView.topAnchor.constraint(equalTo: self.topAnchor),
            satMathSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satMathSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satMathStackView.heightAnchor.constraint(equalTo: satMathSubView.heightAnchor, multiplier: 0.8),
            satMathStackView.widthAnchor.constraint(equalTo: satMathSubView.widthAnchor, multiplier: 0.8),
            satMathStackView.centerXAnchor.constraint(equalTo: satMathSubView.centerXAnchor),
            satMathStackView.centerYAnchor.constraint(equalTo: satMathSubView.centerYAnchor),
            satMathLabel.topAnchor.constraint(equalTo: satMathStackView.topAnchor),
            satMathLabel.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.4),
            satMathLabel.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.9),
            satMathLabel.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),
            satMathScore.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor),
            satMathScore.heightAnchor.constraint(equalTo: satMathStackView.heightAnchor, multiplier: 0.3),
            satMathScore.widthAnchor.constraint(equalTo: satMathStackView.widthAnchor, multiplier: 0.8),
            satMathScore.centerXAnchor.constraint(equalTo: satMathStackView.centerXAnchor),

            satWritingSubView.topAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satWritingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satWritingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satWritingStackView.heightAnchor.constraint(equalTo: satWritingSubView.heightAnchor, multiplier: 0.8),
            satWritingStackView.widthAnchor.constraint(equalTo: satWritingSubView.widthAnchor, multiplier: 0.8),
            satWritingStackView.centerXAnchor.constraint(equalTo: satWritingSubView.centerXAnchor),
            satWritingStackView.centerYAnchor.constraint(equalTo: satWritingSubView.centerYAnchor),
            satWritingLabel.topAnchor.constraint(equalTo: satWritingStackView.topAnchor),
            satWritingLabel.heightAnchor.constraint(equalTo: satWritingStackView.heightAnchor, multiplier: 0.4),
            satWritingLabel.widthAnchor.constraint(equalTo: satWritingStackView.widthAnchor, multiplier: 0.9),
            satWritingLabel.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingScore.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor),
            satWritingScore.heightAnchor.constraint(equalTo: satWritingStackView.heightAnchor, multiplier: 0.3),
            satWritingScore.widthAnchor.constraint(equalTo: satWritingStackView.widthAnchor, multiplier: 0.8),
            satWritingScore.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),

            satReadingSubView.topAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satReadingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satReadingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satReadingStackView.heightAnchor.constraint(equalTo: satReadingSubView.heightAnchor, multiplier: 0.8),
            satReadingStackView.widthAnchor.constraint(equalTo: satReadingSubView.widthAnchor, multiplier: 0.8),
            satReadingStackView.centerXAnchor.constraint(equalTo: satReadingSubView.centerXAnchor),
            satReadingStackView.centerYAnchor.constraint(equalTo: satReadingSubView.centerYAnchor),
            satReadingLabel.topAnchor.constraint(equalTo: satReadingStackView.topAnchor),
            satReadingLabel.heightAnchor.constraint(equalTo: satReadingStackView.heightAnchor, multiplier: 0.4),
            satReadingLabel.widthAnchor.constraint(equalTo: satReadingStackView.widthAnchor, multiplier: 0.9),
            satReadingLabel.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            satReadingScore.topAnchor.constraint(equalTo: satReadingLabel.bottomAnchor),
            satReadingScore.heightAnchor.constraint(equalTo: satReadingStackView.heightAnchor, multiplier: 0.3),
            satReadingScore.widthAnchor.constraint(equalTo: satReadingStackView.widthAnchor, multiplier: 0.8),
            satReadingScore.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
        ])
    }
}
