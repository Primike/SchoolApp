//
//  SchoolsCell.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/3/22.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    var schoolNameLabel = UILabel()
    var addressLabel = UILabel()
    var boroLabel = UILabel()
    var stackView = UIStackView()
    var cellStackView = UIStackView()

    static let reuseID = "SchoolCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SchoolTableViewCell {
    private func setup() {
        self.layer.borderWidth = 7
        self.layer.cornerCurve = CALayerCornerCurve(rawValue: "large")
        self.layer.borderColor = UIColor.systemFill.cgColor
        
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        schoolNameLabel.textAlignment = .left
        schoolNameLabel.text = "schoolName"
        schoolNameLabel.adjustsFontSizeToFitWidth = true

        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        addressLabel.textAlignment = .left
        addressLabel.text = "address"
        addressLabel.adjustsFontSizeToFitWidth = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        boroLabel.translatesAutoresizingMaskIntoConstraints = false
        boroLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        boroLabel.text = ""
        boroLabel.adjustsFontSizeToFitWidth = true
        boroLabel.textAlignment = .left

        
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .horizontal
        cellStackView.alignment = .fill
    }

    private func layout() {
        stackView.addSubview(schoolNameLabel)
        stackView.addSubview(addressLabel)
        
        cellStackView.addSubview(stackView)
        cellStackView.addSubview(boroLabel)
        
        contentView.addSubview(cellStackView)

        NSLayoutConstraint.activate([
            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leftAnchor.constraint(equalTo: cellStackView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.80),
            
            schoolNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            schoolNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor),
            addressLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            boroLabel.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
            boroLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
