//
//  Top10SchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class TopSchoolsHeaderView: UIView {

    lazy var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var topSchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Top Schools By Total SAT Score", labelTextColor: .white)
        return label
    }()
    
    lazy var filterStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var topLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Top", labelTextColor: .white)
        return label
    }()

    lazy var schoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Schools", labelTextColor: .white)
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
        filterStackView.addSubview(topLabel)
        filterStackView.addSubview(schoolsLabel)

        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            topSchoolsLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            topSchoolsLabel.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            topSchoolsLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            topSchoolsLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.5),
            
            filterStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            filterStackView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            filterStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            filterStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.4),
            
            topLabel.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            topLabel.leftAnchor.constraint(equalTo: filterStackView.leftAnchor),
            topLabel.heightAnchor.constraint(equalTo: filterStackView.heightAnchor),
            topLabel.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.3),
            
            schoolsLabel.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            schoolsLabel.rightAnchor.constraint(equalTo: filterStackView.rightAnchor),
            schoolsLabel.heightAnchor.constraint(equalTo: filterStackView.heightAnchor),
            schoolsLabel.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.3),
        ])
    }
}
