//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class SchoolsListHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

    lazy var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.spacing = 10
        return stackView
    }()
    
    lazy var labelsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "NYC High School List")
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Last Updated September 10, 2018")
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    lazy var imageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "book.circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private func layout() {
        self.addSubview(headerStackView)

        headerStackView.addArrangedSubview(labelsStackView)
        headerStackView.addArrangedSubview(imageView)
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            labelsStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.75),
            
            titleLabel.heightAnchor.constraint(equalTo: labelsStackView.heightAnchor, multiplier: 0.6),
        ])
    }
}
