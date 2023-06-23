//
//  MySchoolsEmptyView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/28/22.
//

import Foundation
import UIKit

class MySchoolsHeaderView: UIView {
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var mySchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Add Schools And They Will Appear Here!", labelTextColor: .white)
        return label
    }()

    lazy var heartImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "heart.circle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemRed
        return image
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
            
            mySchoolsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8),
            mySchoolsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
            mySchoolsLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            mySchoolsLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}
