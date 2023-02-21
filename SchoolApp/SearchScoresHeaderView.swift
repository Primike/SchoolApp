//
//  SearchSATScoresView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchScoresHeaderView: UIView {

    lazy var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var topSchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .white)
        return label
    }()
    
    lazy var filterStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var scoreStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    lazy var scoreLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Score", labelTextColor: .white)
        return label
    }()

    lazy var numberStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    lazy var numberOfSchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "# Of Schools", labelTextColor: .white)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func layout() {
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(topSchoolsLabel)
        headerStackView.addSubview(filterStackView)
        filterStackView.addSubview(scoreStackView)
        filterStackView.addSubview(numberStackView)
        
        scoreStackView.addSubview(scoreLabel)
        
        numberStackView.addSubview(numberOfSchoolsLabel)

        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            topSchoolsLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            topSchoolsLabel.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            topSchoolsLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            topSchoolsLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.4),
            
            filterStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            filterStackView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            filterStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            filterStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.5),
            
            scoreStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            scoreStackView.leftAnchor.constraint(equalTo: filterStackView.leftAnchor),
            scoreStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            scoreStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            
            numberStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            numberStackView.rightAnchor.constraint(equalTo: filterStackView.rightAnchor),
            numberStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            numberStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            
            scoreLabel.topAnchor.constraint(equalTo: scoreStackView.topAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: scoreStackView.leftAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: scoreStackView.heightAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.45),
            
            numberOfSchoolsLabel.topAnchor.constraint(equalTo: numberStackView.topAnchor),
            numberOfSchoolsLabel.leftAnchor.constraint(equalTo: numberStackView.leftAnchor),
            numberOfSchoolsLabel.heightAnchor.constraint(equalTo: numberStackView.heightAnchor),
            numberOfSchoolsLabel.widthAnchor.constraint(equalTo: numberStackView.widthAnchor, multiplier: 0.45),
        ])
    }
}
