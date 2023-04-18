//
//  SchoolsCell.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/3/22.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    lazy var cellStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var schoolInfoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var schoolNameLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolAddressLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var schoolBoroLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    static let reuseID = "SchoolCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SchoolCellMethods, indexPath: IndexPath) {
        setup()
        layout()
        
        schoolNameLabel.text = viewModel.getSchoolName(indexPath: indexPath)
        schoolAddressLabel.text = viewModel.getSchoolAddress(indexPath: indexPath)
        schoolBoroLabel.text = viewModel.getSchoolBoro(indexPath: indexPath)
        schoolBoroLabel.textColor = viewModel.getSchoolColor(indexPath: indexPath)
        schoolNameLabel.textColor = viewModel.getSchoolColor(indexPath: indexPath)
    }
    
    private func setup() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }

    private func layout() {
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
