//
//  SchoolInfoBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoBottomView: UIView {
    
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var aboutLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "About:", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var schoolDescription: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: viewModel.schoolData.school.overview_paragraph, fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
        
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(aboutLabel)
        stackView.addArrangedSubview(schoolDescription)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            aboutLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.15)
        ])
    }
}
