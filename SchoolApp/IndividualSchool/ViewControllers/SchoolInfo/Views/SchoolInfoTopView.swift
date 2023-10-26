//
//  SchoolInfoTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoTopView: UIView {
    
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Buttons
    lazy var buttonsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        return stackView
    }()
    
    lazy var websiteButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("School Website", for: [])
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.configuration = .filled()
        button.tintColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        return button
    }()
    
    lazy var addSchoolButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        return button
    }()

    // MARK: - School Info
    lazy var infoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var schoolNameLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: viewModel.schoolData.school.school_name, fontSize: .largeTitle)
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        label.textColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var locationLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Address: \(viewModel.schoolData.school.location)", fontSize: .title3)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        label.textAlignment = .left
        return label
    }()

    lazy var phoneLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Phone: \(viewModel.schoolData.school.phone_number)", fontSize: .title3)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        label.textAlignment = .left
        return label
    }()

    // MARK: - Image
    lazy var schoolImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "book.circle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        return image
    }()

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(buttonsStackView)
        buttonsStackView.addSubview(websiteButton)
        buttonsStackView.addSubview(addSchoolButton)
        self.addSubview(infoStackView)
        infoStackView.addArrangedSubview(schoolNameLabel)
        infoStackView.addArrangedSubview(locationLabel)
        infoStackView.addArrangedSubview(phoneLabel)
        self.addSubview(schoolImage)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            buttonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            websiteButton.leftAnchor.constraint(equalTo: buttonsStackView.leftAnchor),
            websiteButton.centerYAnchor.constraint(equalTo: buttonsStackView.centerYAnchor),
            websiteButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.5),
            
            addSchoolButton.rightAnchor.constraint(equalTo: buttonsStackView.rightAnchor),
            addSchoolButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor),
            addSchoolButton.widthAnchor.constraint(equalTo: buttonsStackView.heightAnchor),
            addSchoolButton.centerYAnchor.constraint(equalTo: buttonsStackView.centerYAnchor),

            infoStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            infoStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            infoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            infoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            schoolNameLabel.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.5),
            
            schoolImage.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor),
            schoolImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            schoolImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
        ])
    }
}
