//
//  SchoolScoresTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresTopView: UIView {
    
    let schoolNameLabel = UILabel()
    let headerStackView = UIStackView()
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
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        schoolNameLabel.text = school.school_name
        schoolNameLabel.textColor = .white
        schoolNameLabel.textAlignment = .center
        schoolNameLabel.adjustsFontSizeToFitWidth = true
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal

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
        self.addSubview(schoolNameLabel)
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(collegeBoardImage)
        headerStackView.addSubview(scoresInfoStackView)
        
        scoresInfoStackView.addSubview(scoresLabel)
        scoresInfoStackView.addSubview(testTakersLabel)
        
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            schoolNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            schoolNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            
            headerStackView.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5),
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            collegeBoardImage.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            collegeBoardImage.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.9),
            collegeBoardImage.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.4),
            collegeBoardImage.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),

            scoresInfoStackView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            scoresInfoStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.9),
            scoresInfoStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.5),
            scoresInfoStackView.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),
            
            scoresLabel.topAnchor.constraint(equalTo: scoresInfoStackView.topAnchor),
            scoresLabel.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.3),
            scoresLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            scoresLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),

            testTakersLabel.topAnchor.constraint(equalTo: scoresLabel.bottomAnchor),
            testTakersLabel.heightAnchor.constraint(equalTo: scoresInfoStackView.heightAnchor, multiplier: 0.3),
            testTakersLabel.widthAnchor.constraint(equalTo: scoresInfoStackView.widthAnchor),
            testTakersLabel.centerXAnchor.constraint(equalTo: scoresInfoStackView.centerXAnchor),

        ])
    }
}
