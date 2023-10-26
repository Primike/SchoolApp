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

    lazy var cellStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        return stackView
    }()

    lazy var infoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var schoolName: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var schoolAddress: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var schoolBoro: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "", fontSize: .largeTitle)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0)
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
        layer.borderWidth = 5
        layer.borderColor = UIColor.systemFill.cgColor
        layer.cornerRadius = 20
        layer.masksToBounds = true
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }

    private func layout() {
        self.addSubview(cellStackView)

        cellStackView.addSubview(infoStackView)
        cellStackView.addSubview(schoolBoro)

        infoStackView.addArrangedSubview(schoolName)
        infoStackView.addArrangedSubview(schoolAddress)

        NSLayoutConstraint.activate([
            cellStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            cellStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            infoStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            infoStackView.leftAnchor.constraint(equalTo: cellStackView.leftAnchor),
            infoStackView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.8),
            infoStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.7),

            schoolName.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.6),

            schoolBoro.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            schoolBoro.rightAnchor.constraint(equalTo: cellStackView.rightAnchor),
            schoolBoro.heightAnchor.constraint(equalTo: cellStackView.heightAnchor ,multiplier: 0.3),
            schoolBoro.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.2),
        ])
    }
}
