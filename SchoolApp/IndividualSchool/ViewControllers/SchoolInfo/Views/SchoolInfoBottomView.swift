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
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var aboutLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "About:"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var schoolDescription: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = viewModel.schoolData.school.overview_paragraph
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
        
    private func layout() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(aboutLabel)
        stackView.addArrangedSubview(schoolDescription)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
