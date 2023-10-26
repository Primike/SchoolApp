//
//  LoaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/3/22.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var verticalStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()

    lazy var appTitleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Schools App", fontSize: .largeTitle)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        label.numberOfLines = 1
        return label
    }()

    lazy var appImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "appimage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.color = .systemBlue
//        indicator.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        return indicator
    }()
    
    private func layout() {
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(activityIndicator)
        
        horizontalStackView.addArrangedSubview(appTitleLabel)
        horizontalStackView.addArrangedSubview(appImage)
        
        NSLayoutConstraint.activate([
            verticalStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            verticalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            appTitleLabel.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            
            appImage.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
        ])
    }
}
