//
//  LoadingView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/3/22.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    let gradient = CAGradientLayer()
    let stackView = UIStackView()
    let appTitleLabel = UILabel()
    let appImage = UIImageView(image: UIImage(named: "appimage"))
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        self.layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        gradient.frame = self.layer.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.blue.cgColor]
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        appTitleLabel.text = "Schools App"
        appTitleLabel.textColor = .black
        appTitleLabel.adjustsFontSizeToFitWidth = true
        appTitleLabel.textAlignment = .center
        
        appImage.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
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
