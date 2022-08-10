//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class SchoolsListHeaderView: UIView {

    let headerStackView = UIStackView()
    let labelsStackView = UIStackView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    let date = Date()
    let dateFormatter = DateFormatter()

    let imageView = UIImageView(image: UIImage(systemName: "book.circle"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

    func setup() {
        dateFormatter.dateFormat = "MM/dd/YY hh:mm:ss"
        let _ = dateFormatter.string(from: date)

        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal

        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0 )
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .left
        titleLabel.text = "NYC High School List"
        titleLabel.textColor = .black

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name:"HelveticaNeue", size: 20.0 )
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.textAlignment = .left
        dateLabel.text = "Last Updated September 10, 2018"
        dateLabel.textColor = .black

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
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
