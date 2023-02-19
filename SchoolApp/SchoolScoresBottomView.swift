//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresBottomView: UIView {
    
    lazy var satMathSubView: BottomSubjectView = {
        var view = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT MATH", subjectScore: schoolScores.sat_math_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var satWritingSubView: BottomSubjectView = {
        var view = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT WRITING", subjectScore: schoolScores.sat_writing_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var satReadingSubView: BottomSubjectView = {
        var view = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT CRITICAL READING", subjectScore: schoolScores.sat_critical_reading_avg_score)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let school: School
    let schoolScores: SATScores
    let schoolColor: UIColor

    init(frame: CGRect, school: School, schoolScores: SATScores, schoolColor: UIColor) {
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
        self.addSubview(satMathSubView)
        self.addSubview(satWritingSubView)
        self.addSubview(satReadingSubView)
        
        NSLayoutConstraint.activate([
            satMathSubView.topAnchor.constraint(equalTo: self.topAnchor),
            satMathSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satMathSubView.widthAnchor.constraint(equalTo: self.widthAnchor),

            satWritingSubView.topAnchor.constraint(equalTo: satMathSubView.bottomAnchor),
            satWritingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satWritingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),

            satReadingSubView.topAnchor.constraint(equalTo: satWritingSubView.bottomAnchor),
            satReadingSubView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            satReadingSubView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
}




