//
//  LoadingView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/22/22.
//

import Foundation
import UIKit

class LoadingView: UIView {
    var activityIndicator = UIActivityIndicatorView(style: .large)
    let chungusImage = UIImageView(image: UIImage(named: "drchungus"))
    let appTitle = UILabel()
    let chungusLabel = UILabel()
    let loadingStackView = UIStackView()

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        loadingStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingStackView.axis = .vertical
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        
        chungusImage.translatesAutoresizingMaskIntoConstraints = false
        
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        appTitle.textAlignment = .left
        appTitle.text = "The School App"
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.numberOfLines = 0
        appTitle.textAlignment = .center
        
        chungusLabel.translatesAutoresizingMaskIntoConstraints = false
        chungusLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        chungusLabel.textAlignment = .left
        chungusLabel.text = "Powered By Dr Chungus"
        chungusLabel.adjustsFontSizeToFitWidth = true
        chungusLabel.numberOfLines = 0
        chungusLabel.textAlignment = .center
        
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()  
    }
    
    func layout() {
        addSubview(loadingStackView)
        
        loadingStackView.addSubview(chungusImage)
        loadingStackView.addSubview(appTitle)
        loadingStackView.addSubview(activityIndicator)
        loadingStackView.addSubview(chungusLabel)

        NSLayoutConstraint.activate([
            loadingStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            loadingStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            loadingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            chungusImage.topAnchor.constraint(equalTo: loadingStackView.topAnchor),
            chungusImage.widthAnchor.constraint(equalTo: loadingStackView.widthAnchor, multiplier: 0.4),
            chungusImage.centerXAnchor.constraint(equalTo: loadingStackView.centerXAnchor),
            chungusImage.heightAnchor.constraint(equalTo: loadingStackView.heightAnchor, multiplier: 0.3),
            
            appTitle.topAnchor.constraint(equalTo: chungusImage.bottomAnchor),
            appTitle.widthAnchor.constraint(equalTo: loadingStackView.widthAnchor, multiplier: 0.9),
            appTitle.heightAnchor.constraint(equalTo: loadingStackView.heightAnchor, multiplier: 0.2),
            appTitle.centerXAnchor.constraint(equalTo: loadingStackView.centerXAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: appTitle.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingStackView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingStackView.centerYAnchor),
            
            chungusLabel.bottomAnchor.constraint(equalTo: loadingStackView.bottomAnchor),
            chungusLabel.heightAnchor.constraint(equalTo: loadingStackView.heightAnchor, multiplier: 0.15),
            chungusLabel.centerXAnchor.constraint(equalTo: loadingStackView.centerXAnchor),
        ])
    }
}
