//
//  BottomSubjectView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/4/22.
//

import Foundation
import UIKit

class BottomSubjectView: UIView {
    
    let schoolColor: UIColor
    let subjectName: String
    let subjectScore: String
    
    init(schoolColor: UIColor, subjectName: String, subjectScore: String) {
        self.schoolColor = schoolColor
        self.subjectName = subjectName
        self.subjectScore = subjectScore
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var satSubjectStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.backgroundColor = schoolColor
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    lazy var satSubjectLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: subjectName, fontSize: .largeTitle)
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    lazy var satSubjectScore: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Score: \(subjectScore)/800", fontSize: .title1)
        label.textColor = .white
        return label
    }()
    
    private func layout() {
        self.addSubview(satSubjectStackView)
        satSubjectStackView.addArrangedSubview(satSubjectLabel)
        satSubjectStackView.addArrangedSubview(satSubjectScore)
        
        NSLayoutConstraint.activate([
            satSubjectStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            satSubjectStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            satSubjectStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            satSubjectStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
