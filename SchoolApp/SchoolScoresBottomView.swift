//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresBottomView: UIView {
    
    let satMathSubView: BottomSubjectView

    let satWritingSubView: BottomSubjectView

    let satReadingSubView: BottomSubjectView

    let school: School
    let schoolScores: SATScores
    let schoolColor: UIColor

    init(frame: CGRect, school: School, schoolScores: SATScores, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        self.schoolScores = schoolScores
        
        self.satMathSubView = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT MATH", subjectScore: schoolScores.sat_math_avg_score)
        self.satWritingSubView = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT WRITING", subjectScore: schoolScores.sat_writing_avg_score)
        self.satReadingSubView = BottomSubjectView(frame: CGRect(), schoolColor: schoolColor, subjectName: "SAT CRITICAL READING", subjectScore: schoolScores.sat_critical_reading_avg_score)
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        satMathSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satWritingSubView.translatesAutoresizingMaskIntoConstraints = false
        
        satReadingSubView.translatesAutoresizingMaskIntoConstraints = false
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




