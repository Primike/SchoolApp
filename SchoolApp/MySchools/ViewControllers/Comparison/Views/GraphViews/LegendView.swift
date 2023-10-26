//
//  LegendView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class LegendView: UIView {
    
    let schoolName1: String
    let schoolName2: String
    
    init(schoolName1: String, schoolName2: String) {
        self.schoolName1 = schoolName1
        self.schoolName2 = schoolName2
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var school1StackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var school1Box: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var school1Label: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: schoolName1, fontSize: .largeTitle)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var school2StackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var school2Box: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var school2Label: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: schoolName2, fontSize: .largeTitle)
        label.textColor = .brown
        label.numberOfLines = 2
        return label
    }()
            
    private func layout() {
        self.addSubview(school1StackView)
        self.addSubview(school2StackView)
        
        school1StackView.addArrangedSubview(school1Box)
        school1StackView.addArrangedSubview(school1Label)
        school2StackView.addArrangedSubview(school2Box)
        school2StackView.addArrangedSubview(school2Label)
        
        NSLayoutConstraint.activate([
            school1StackView.topAnchor.constraint(equalTo: self.topAnchor),
            school1StackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            school1StackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            school1StackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            
            school2StackView.topAnchor.constraint(equalTo: self.topAnchor),
            school2StackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            school2StackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            school2StackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),

            school1Box.widthAnchor.constraint(equalTo: school1StackView.widthAnchor, multiplier: 0.25),
            school2Box.widthAnchor.constraint(equalTo: school2StackView.widthAnchor, multiplier: 0.25),
        ])
    }
}
