//
//  CompareHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/11/22.
//

import Foundation
import UIKit

class ComparisonHeaderView: UIView {
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mySchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Select Two Schools To Compare Details", labelTextColor: .white)
        return label
    }()
    
    lazy var heartImage: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "heart.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func layout() {
        self.addSubview(stackView)
        
//        stackView.addSubview(heartImage)
        stackView.addSubview(mySchoolsLabel)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
//            heartImage.leftAnchor.constraint(equalTo: stackView.leftAnchor),
//            heartImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8),
//            heartImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3),
//            heartImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            mySchoolsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            mySchoolsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8),
            mySchoolsLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            mySchoolsLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}
