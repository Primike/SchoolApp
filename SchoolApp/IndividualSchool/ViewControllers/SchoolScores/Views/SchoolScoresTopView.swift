//
//  SchoolScoresTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolScoresTopView: UIView {
    
    let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var schoolNameLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: viewModel.school.school_name, labelTextColor: .white)
        return label
    }()

    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
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
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    lazy var scoresLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "SAT Scores"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var testTakersLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "Number of test takers: \(viewModel.satData.num_of_sat_test_takers)"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
      
    lazy var graphButton: UIButton = {
//        var configuration = UIButton.Configuration.plain()
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        let button = UIButton(configuration: configuration, primaryAction: nil)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Scores Graph", for: .normal)
        button.backgroundColor = UIColor.black
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .title3).pointSize
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    func layout() {
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
            
            headerStackView.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5),
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
