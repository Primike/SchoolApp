//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class SchoolsListHeaderView: UIView {

    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var labelsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var titleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "NYC High School List", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0 )
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Last Updated September 10, 2018", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue", size: 20.0 )
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
    
    lazy var date: Date = {
        var date = Date()
        return date
    }()
    
    lazy var dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY hh:mm:ss"
        let _ = dateFormatter.string(from: date)
        return dateFormatter
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

    func layout() {
        self.addSubview(headerStackView)

        headerStackView.addSubview(labelsStackView)
        headerStackView.addSubview(imageView)
        
        labelsStackView.addSubview(titleLabel)
        labelsStackView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            labelsStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            labelsStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            labelsStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.6),

            titleLabel.topAnchor.constraint(equalTo: labelsStackView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: labelsStackView.leftAnchor),
            titleLabel.heightAnchor.constraint(equalTo: labelsStackView.heightAnchor, multiplier: 0.5),
            titleLabel.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: labelsStackView.leftAnchor),
            dateLabel.heightAnchor.constraint(equalTo: labelsStackView.heightAnchor, multiplier: 0.3),
            dateLabel.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: labelsStackView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: labelsStackView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: labelsStackView.heightAnchor),
        ])
    }
}
