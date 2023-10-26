//
//  SchoolScoresBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresBottomView: UIView {
    
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        layout()
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var satMathSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro), subjectName: "SAT MATH", subjectScore: viewModel.schoolData.sat.sat_math_avg_score)
        return view
    }()

    lazy var satWritingSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro), subjectName: "SAT WRITING", subjectScore: viewModel.schoolData.sat.sat_writing_avg_score)
        return view
    }()

    lazy var satReadingSubView: BottomSubjectView = {
        var view = BottomSubjectView(schoolColor: viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro), subjectName: "SAT CRITICAL READING", subjectScore: viewModel.schoolData.sat.sat_critical_reading_avg_score)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layout() {
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
