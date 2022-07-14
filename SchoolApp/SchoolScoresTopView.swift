//
//  SchoolScoresTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresTopView: UIView {
    
    let schoolName = UILabel()
    let scoresHeaderStackView = UIStackView()
    let collegeBoardImage = UIImageView(image: UIImage(named: "satheader"))
    let scoresInfoStackView = UIStackView()
    let scoresLabel = UILabel()
    let testTakersLabel = UILabel()
    
    let school: School
    let schoolScores: SchoolScores
    let schoolColor: UIColor
    
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
    }
    
    func layout() {
        self.addSubview(schoolName)
        self.addSubview(scoresHeaderStackView)
        scoresHeaderStackView.addSubview(collegeBoardImage)
        scoresHeaderStackView.addSubview(scoresInfoStackView)
        scoresInfoStackView.addSubview(scoresLabel)
        scoresInfoStackView.addSubview(testTakersLabel)
        
        NSLayoutConstraint.activate([
            schoolName.topAnchor.constraint(equalTo: self.topAnchor),
            schoolName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            schoolName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            schoolName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            
            
            scoresHeaderStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            scoresHeaderStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            scoresHeaderStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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

        ])
    }
}
