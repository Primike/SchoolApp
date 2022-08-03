//
//  SchoolsCell.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/3/22.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    let cellStackView = UIStackView()
    let schoolInfoStackView = UIStackView()
    let schoolNameLabel = UILabel()
    let schoolAddressLabel = UILabel()
    let schoolBoroLabel = UILabel()

    static let reuseID = "SchoolCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .horizontal
        
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        schoolInfoStackView.axis = .vertical
        
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        schoolNameLabel.textAlignment = .left
        schoolNameLabel.adjustsFontSizeToFitWidth = true
        schoolNameLabel.numberOfLines = 2

        schoolAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolAddressLabel.font = UIFont(name:"HelveticaNeue", size: 20.0)
        schoolAddressLabel.textAlignment = .left
        schoolAddressLabel.adjustsFontSizeToFitWidth = true
        
        schoolBoroLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolBoroLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        schoolBoroLabel.adjustsFontSizeToFitWidth = true
        schoolBoroLabel.textAlignment = .right

    }
    
    func configure(info: (schoolName: String, schoolAddress: String, schoolBoro: String)) {
        self.schoolNameLabel.text = info.schoolName
        self.schoolAddressLabel.text = info.schoolAddress
        self.schoolBoroLabel.text = info.schoolBoro
        self.schoolBoroLabel.textColor = getColor(schoolBoro: info.schoolBoro)
        self.schoolNameLabel.textColor = getColor(schoolBoro: info.schoolBoro)
    }
    
    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.systemRed
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }

    func layout() {
        self.addSubview(cellStackView)

        cellStackView.addSubview(schoolInfoStackView)
        cellStackView.addSubview(schoolBoroLabel)
        
        schoolInfoStackView.addSubview(schoolNameLabel)
        schoolInfoStackView.addSubview(schoolAddressLabel)

        NSLayoutConstraint.activate([
            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            schoolInfoStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            schoolInfoStackView.leftAnchor.constraint(equalTo: cellStackView.leftAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.7),
            
            schoolNameLabel.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            schoolNameLabel.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.5),
            schoolNameLabel.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor),
            
            schoolAddressLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor),
            schoolAddressLabel.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
            schoolAddressLabel.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.3),
            schoolAddressLabel.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.9),
            
            schoolBoroLabel.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            schoolBoroLabel.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
            schoolBoroLabel.heightAnchor.constraint(equalTo: cellStackView.heightAnchor ,multiplier: 0.3),
            schoolBoroLabel.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.2),
        ])
    }
}
