//
//  SchoolScoresTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresTopView: UIView {
    
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var schoolNameLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: viewModel.schoolData.school.school_name, fontSize: .largeTitle)
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        return label
    }()

    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()

    lazy var collegeBoardImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "satheader"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var scoresInfoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    lazy var scoresLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "SAT Scores", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textColor = .white
        return label
    }()

    lazy var testTakersLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Number of test takers: \(viewModel.schoolData.sat.num_of_sat_test_takers)", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
      
    lazy var graphButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Scores Graph", for: .normal)
        button.backgroundColor = UIColor.black
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    private func layout() {
        backgroundColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        
        self.addSubview(schoolNameLabel)
        self.addSubview(headerStackView)
        headerStackView.addArrangedSubview(collegeBoardImage)
        headerStackView.addArrangedSubview(scoresInfoStackView)
        scoresInfoStackView.addArrangedSubview(scoresLabel)
        scoresInfoStackView.addArrangedSubview(testTakersLabel)
        scoresInfoStackView.addArrangedSubview(graphButton)
        
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            schoolNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            schoolNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 10),
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
