//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class SchoolsListHeaderView: UIView {
    let typeLabel = UILabel()

    let headerStackView = UIStackView()
    let infoStackView = UIStackView()
    let schoolName = UILabel()
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
        let todaysDate = dateFormatter.string(from: date)

        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal

        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"TrebuchetMS-Bold", size: 40.0 )
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.textAlignment = .left
        schoolName.text = "NYC Schools App"
        schoolName.numberOfLines = 0

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name:"TrebuchetMS", size: 12.0 )
        dateLabel.text = "Data Last Fetched: \(todaysDate)"
        dateLabel.numberOfLines = 0

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
    }

    func layout() {
        self.addSubview(headerStackView)

        infoStackView.addSubview(schoolName)
        infoStackView.addSubview(dateLabel)
        headerStackView.addSubview(infoStackView)
        headerStackView.addSubview(imageView)

        //stack view
        NSLayoutConstraint.activate([
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),


            infoStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.6),
            infoStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            infoStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            infoStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),

            schoolName.widthAnchor.constraint(equalTo: infoStackView.widthAnchor),
            schoolName.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 10),
            schoolName.leftAnchor.constraint(equalTo: infoStackView.leftAnchor),
            schoolName.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.4),

            dateLabel.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: infoStackView.widthAnchor),
            dateLabel.leftAnchor.constraint(equalTo: infoStackView.leftAnchor),
            dateLabel.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.3),

            imageView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: infoStackView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 1),
        ])

    }
}
