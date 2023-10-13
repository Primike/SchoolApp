//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresBottomView: UIView {
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var satMathSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: schoolColor, subjectName: "SAT MATH", subjectScore: schoolScores.sat_math_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var satWritingSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: schoolColor, subjectName: "SAT WRITING", subjectScore: schoolScores.sat_writing_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var satReadingSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: schoolColor, subjectName: "SAT CRITICAL READING", subjectScore: schoolScores.sat_critical_reading_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(satMathSubView)
        stackView.addArrangedSubview(satWritingSubView)
        stackView.addArrangedSubview(satReadingSubView)
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
        ])
    }
}




