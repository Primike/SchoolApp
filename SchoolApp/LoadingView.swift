//
//  LoadingView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/3/22.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var appTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.text = "Schools App"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var appImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "appimage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.color = .systemBlue
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(stackView)
        self.addSubview(activityIndicator)

        stackView.addSubview(appTitleLabel)
        stackView.addSubview(appImage)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            appTitleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            appTitleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            appTitleLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            appTitleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7),
            
            appImage.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            appImage.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            appImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            appImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
