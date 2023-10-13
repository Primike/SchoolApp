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
    
    lazy var topButtonsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var schoolInfoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    lazy var schoolName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = viewModel.school.school_name
        label.textColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var schoolLocation: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .headline).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "Address: \(viewModel.school.location)"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    lazy var schoolPhone: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .headline).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "Phone: \(viewModel.school.phone_number)"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    lazy var schoolImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "book.circle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        return image
    }()

    private func layout() {
        self.addSubview(topButtonsStackView)
        self.addSubview(schoolInfoStackView)
        schoolInfoStackView.addArrangedSubview(schoolName)
        schoolInfoStackView.addArrangedSubview(schoolLocation)
        schoolInfoStackView.addArrangedSubview(schoolPhone)
        self.addSubview(schoolImage)
        
        NSLayoutConstraint.activate([
            topButtonsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            topButtonsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            topButtonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            topButtonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            schoolInfoStackView.topAnchor.constraint(equalTo: topButtonsStackView.bottomAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            schoolInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            schoolInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            schoolImage.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            schoolImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            schoolImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
        ])
    }
}
