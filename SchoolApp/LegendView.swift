//
//  LegendView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class LegendView: UIView {
    
    lazy var school1StackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var school1Box: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.backgroundColor = .black
        return stackView
    }()
    
    lazy var school1Label: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: schoolName1, labelTextColor: .black)
        return label
    }()
    
    lazy var school2StackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var school2Box: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.backgroundColor = .brown
        return stackView
    }()
    
    lazy var school2Label: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: schoolName2, labelTextColor: .brown)
        return label
    }()
    
    let schoolName1: String
    let schoolName2: String
    
    init(frame: CGRect, schoolName1: String, schoolName2: String) {
        self.schoolName1 = schoolName1
        self.schoolName2 = schoolName2
        
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func layout() {
        self.addSubview(school1StackView)
        self.addSubview(school2StackView)
        
        school1StackView.addSubview(school1Box)
        school1StackView.addSubview(school1Label)
        school2StackView.addSubview(school2Box)
        school2StackView.addSubview(school2Label)
        
        NSLayoutConstraint.activate([
            school1StackView.topAnchor.constraint(equalTo: self.topAnchor),
            school1StackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            school1StackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            school1StackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            
            school1Box.leftAnchor.constraint(equalTo: school1StackView.leftAnchor),
            school1Box.heightAnchor.constraint(equalTo: school1StackView.heightAnchor, multiplier: 0.8),
            school1Box.widthAnchor.constraint(equalTo: school1StackView.heightAnchor, multiplier: 0.8),
            school1Box.centerYAnchor.constraint(equalTo: school1StackView.centerYAnchor),
            
            school1Label.topAnchor.constraint(equalTo: school1StackView.topAnchor),
            school1Label.rightAnchor.constraint(equalTo: school1StackView.rightAnchor),
            school1Label.heightAnchor.constraint(equalTo: school1StackView.heightAnchor),
            school1Label.widthAnchor.constraint(equalTo: school1StackView.widthAnchor, multiplier: 0.7),
            
            school2StackView.topAnchor.constraint(equalTo: self.topAnchor),
            school2StackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            school2StackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            school2StackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            
            school2Box.leftAnchor.constraint(equalTo: school2StackView.leftAnchor),
            school2Box.heightAnchor.constraint(equalTo: school2StackView.heightAnchor, multiplier: 0.8),
            school2Box.widthAnchor.constraint(equalTo: school2StackView.heightAnchor, multiplier: 0.8),
            school2Box.centerYAnchor.constraint(equalTo: school2StackView.centerYAnchor),
            
            school2Label.topAnchor.constraint(equalTo: school2StackView.topAnchor),
            school2Label.rightAnchor.constraint(equalTo: school2StackView.rightAnchor),
            school2Label.heightAnchor.constraint(equalTo: school2StackView.heightAnchor),
            school2Label.widthAnchor.constraint(equalTo: school2StackView.widthAnchor, multiplier: 0.7),
        ])
    }
}
