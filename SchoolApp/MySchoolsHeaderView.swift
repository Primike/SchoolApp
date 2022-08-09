//
//  MySchoolsEmptyView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/28/22.
//

import Foundation
import UIKit

class MySchoolsHeaderView: UIView {
    
    let stackView = UIStackView()
    let mySchoolsLabel = UILabel()
    let heartImage = UIImageView(image: UIImage(systemName: "heart.circle.fill"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func setup() {
        self.backgroundColor = .systemBlue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        heartImage.contentMode = .scaleAspectFit
        heartImage.tintColor = .black
        
        mySchoolsLabel.translatesAutoresizingMaskIntoConstraints = false
        mySchoolsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        mySchoolsLabel.adjustsFontSizeToFitWidth = true
        mySchoolsLabel.textAlignment = .center
        mySchoolsLabel.text = "Add Schools And They Will Appear Here!"
        mySchoolsLabel.textColor = .white
        mySchoolsLabel.numberOfLines = 0
    }
    
    func layout() {
        self.addSubview(stackView)
        
        stackView.addSubview(heartImage)
        stackView.addSubview(mySchoolsLabel)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            heartImage.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            heartImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8),
            heartImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3),
            heartImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            mySchoolsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            mySchoolsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
            mySchoolsLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            mySchoolsLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}
