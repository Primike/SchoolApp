//
//  SchoolsCell.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/3/22.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    //Use reuse so the table can reuse the cells and not init new ones
    static let reuseID = "SchoolCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var cellStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var schoolInfoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var schoolName: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolAddress: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var schoolBoro: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    func configure(viewModel: SchoolCellMethods, indexPath: IndexPath) {
        setup()
        layout()
        
        schoolName.text = viewModel.getSchoolName(indexPath: indexPath)
        schoolName.textColor = viewModel.getSchoolColor(indexPath: indexPath)
        schoolAddress.text = viewModel.getSchoolAddress(indexPath: indexPath)
        schoolBoro.text = viewModel.getSchoolBoro(indexPath: indexPath)
        schoolBoro.textColor = viewModel.getSchoolColor(indexPath: indexPath)
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
        cellStackView.addSubview(schoolBoro)
        
        schoolInfoStackView.addArrangedSubview(schoolName)
        schoolInfoStackView.addArrangedSubview(schoolAddress)
        
        NSLayoutConstraint.activate([
            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            schoolInfoStackView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.8),
            schoolInfoStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.6),
            
            schoolName.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.7),
            
            schoolBoro.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
            schoolBoro.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.3)
        ])
    }
}


//class SchoolTableViewCell: UITableViewCell {
//
//    //Use reuse so the table can reuse the cells and not init new ones
//    static let reuseID = "SchoolCell"
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    lazy var cellStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//
//    lazy var schoolInfoStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//
//    lazy var schoolName: SchoolAppLabel = {
//        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
//        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var schoolAddress: SchoolAppLabel = {
//        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
//        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
//        label.numberOfLines = 1
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var schoolBoro: SchoolAppLabel = {
//        var label = SchoolAppLabel(labelText: "", labelTextColor: .black)
//        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.numberOfLines = 1
//        return label
//    }()
//
//    func configure(viewModel: SchoolCellMethods, indexPath: IndexPath) {
//        setup()
//        layout()
//
//        schoolName.text = viewModel.getSchoolName(indexPath: indexPath)
//        schoolName.textColor = viewModel.getSchoolColor(indexPath: indexPath)
//        schoolAddress.text = viewModel.getSchoolAddress(indexPath: indexPath)
//        schoolBoro.text = viewModel.getSchoolBoro(indexPath: indexPath)
//        schoolBoro.textColor = viewModel.getSchoolColor(indexPath: indexPath)
//    }
//
//    private func setup() {
//        self.layer.borderWidth = 5
//        self.layer.borderColor = UIColor.systemFill.cgColor
//        self.layer.cornerRadius = 20
//        self.layer.masksToBounds = true
//        self.accessoryType = .disclosureIndicator
//        self.selectionStyle = .none
//    }
//
//    private func layout() {
//        self.addSubview(cellStackView)
//
//        cellStackView.addSubview(schoolInfoStackView)
//        cellStackView.addSubview(schoolBoro)
//
//        schoolInfoStackView.addSubview(schoolName)
//        schoolInfoStackView.addSubview(schoolAddress)
//
//        NSLayoutConstraint.activate([
//            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
//            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
//            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//
//            schoolInfoStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
//            schoolInfoStackView.leftAnchor.constraint(equalTo: cellStackView.leftAnchor),
//            schoolInfoStackView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor),
//            schoolInfoStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.7),
//
//            schoolName.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
//            schoolName.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
//            schoolName.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.5),
//            schoolName.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor),
//
//            schoolAddress.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
//            schoolAddress.leftAnchor.constraint(equalTo: schoolInfoStackView.leftAnchor),
//            schoolAddress.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.3),
//            schoolAddress.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.9),
//
//            schoolBoro.topAnchor.constraint(equalTo: cellStackView.topAnchor),
//            schoolBoro.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
//            schoolBoro.heightAnchor.constraint(equalTo: cellStackView.heightAnchor ,multiplier: 0.3),
//            schoolBoro.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.2),
//        ])
//    }
//}
