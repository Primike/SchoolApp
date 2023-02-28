//
//  SchoolScoresTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresTopView: UIView {
    
    lazy var schoolNameLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: school.school_name, labelTextColor: .white)
        return label
    }()

    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var collegeBoardImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "satheader"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var scoresInfoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var scoresLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "SAT Scores", labelTextColor: .white)
        return label
    }()

    lazy var testTakersLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Number of test takers: \(schoolScores.num_of_sat_test_takers)", labelTextColor: .white)
        return label
    }()
    
    let school: School
    let schoolScores: SATData
    let schoolColor: UIColor
    
    init(frame: CGRect, school: School, schoolScores: SATData, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        self.schoolScores = schoolScores
        
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
