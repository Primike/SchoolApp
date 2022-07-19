//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

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
            satMathSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satMathSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
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

            satWritingSubView.topAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satWritingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satWritingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satWritingStackView.heightAnchor.constraint(equalTo: satWritingSubView.heightAnchor, multiplier: 0.8),
            satWritingStackView.widthAnchor.constraint(equalTo: satWritingSubView.widthAnchor, multiplier: 0.8),
            satWritingStackView.centerXAnchor.constraint(equalTo: satWritingSubView.centerXAnchor),
            satWritingStackView.centerYAnchor.constraint(equalTo: satWritingSubView.centerYAnchor),
            satWritingLabel.topAnchor.constraint(equalTo: satWritingStackView.topAnchor),
            satWritingLabel.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingLabel.widthAnchor.constraint(equalTo: satWritingStackView.widthAnchor, multiplier: 0.9),
            satWritingLabel.heightAnchor.constraint(equalTo: satWritingStackView.heightAnchor, multiplier: 0.4),
            satWritingScore.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor),
            satWritingScore.centerXAnchor.constraint(equalTo: satWritingStackView.centerXAnchor),
            satWritingScore.widthAnchor.constraint(equalTo: satWritingStackView.widthAnchor, multiplier: 0.8),
            satWritingScore.heightAnchor.constraint(equalTo: satWritingStackView.heightAnchor, multiplier: 0.3),

            satReadingSubView.topAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satReadingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satReadingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satReadingStackView.heightAnchor.constraint(equalTo: satReadingSubView.heightAnchor, multiplier: 0.8),
            satReadingStackView.widthAnchor.constraint(equalTo: satReadingSubView.widthAnchor, multiplier: 0.8),
            satReadingStackView.centerXAnchor.constraint(equalTo: satReadingSubView.centerXAnchor),
            satReadingStackView.centerYAnchor.constraint(equalTo: satReadingSubView.centerYAnchor),
            satReadingLabel.topAnchor.constraint(equalTo: satReadingStackView.topAnchor),
            satReadingLabel.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            satReadingLabel.widthAnchor.constraint(equalTo: satReadingStackView.widthAnchor, multiplier: 0.9),
            satReadingLabel.heightAnchor.constraint(equalTo: satReadingStackView.heightAnchor, multiplier: 0.4),
            satReadingScore.topAnchor.constraint(equalTo: satReadingLabel.bottomAnchor),
            satReadingScore.centerXAnchor.constraint(equalTo: satReadingStackView.centerXAnchor),
            satReadingScore.widthAnchor.constraint(equalTo: satReadingStackView.widthAnchor, multiplier: 0.8),
            satReadingScore.heightAnchor.constraint(equalTo: satReadingStackView.heightAnchor, multiplier: 0.3),
        ])
    }
}
