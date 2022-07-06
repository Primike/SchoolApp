//
//  SchoolsCell.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/3/22.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    let schoolName = UILabel()
    let schoolAddress = UILabel()
    let schoolBoro = UILabel()
    let schoolInfoStackView = UIStackView()
    let cellStackView = UIStackView()

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
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
        
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .horizontal
        cellStackView.alignment = .fill
        
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        schoolInfoStackView.axis = .vertical
        schoolInfoStackView.alignment = .fill
        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        schoolName.textAlignment = .left
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.numberOfLines = 0

        schoolAddress.translatesAutoresizingMaskIntoConstraints = false
        schoolAddress.font = UIFont.preferredFont(forTextStyle: .subheadline)
        schoolAddress.textAlignment = .left
        schoolAddress.adjustsFontSizeToFitWidth = true
        schoolAddress.numberOfLines = 0
        
        
        schoolBoro.translatesAutoresizingMaskIntoConstraints = false
        schoolBoro.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        schoolBoro.adjustsFontSizeToFitWidth = true
        schoolBoro.textAlignment = .right

    }
    
    func configure(info: (schoolName: String, schoolAddress: String, schoolBoro: String)) {
        self.schoolName.text = info.schoolName
        self.schoolAddress.text = info.schoolAddress
        self.schoolBoro.text = info.schoolBoro
        self.schoolBoro.textColor = getColor(schoolBoro: info.schoolBoro)
        self.schoolName.textColor = getColor(schoolBoro: info.schoolBoro)
    }
    
    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return UIColor.systemOrange
        case "K":
            return UIColor.black
        case "Q":
            return UIColor.systemPurple
        default:
            return UIColor.systemGreen
        }
    }

    private func layout() {
        self.addSubview(cellStackView)

        cellStackView.addSubview(schoolInfoStackView)
        cellStackView.addSubview(schoolBoro)
        
        schoolInfoStackView.addSubview(schoolName)
        schoolInfoStackView.addSubview(schoolAddress)
        

        NSLayoutConstraint.activate([
            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            schoolInfoStackView.leftAnchor.constraint(equalTo: cellStackView.leftAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.8),
            schoolInfoStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.7),
            
            schoolName.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            schoolName.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor),
            schoolName.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.5),
            schoolName.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
            
            schoolAddress.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            schoolAddress.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor),
            schoolAddress.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.3),
            schoolAddress.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
            
            schoolBoro.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
            schoolBoro.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.2),
            schoolBoro.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            schoolBoro.heightAnchor.constraint(equalTo: cellStackView.heightAnchor ,multiplier: 0.3),
        ])
    }
}
