//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation
import UIKit

class SchoolListHeaderView: UIView {
    @IBOutlet var header: UIView!
    let typeLabel = UILabel()

    let labelStackView = UIStackView()
    let headerStackView = UIStackView()
    let nycSchoolsLabel = UILabel()
    let dateLabel = UILabel()

    let date = Date()
    let dateFormatter = DateFormatter()

    let imageView = UIImageView(image: UIImage(systemName: "book.circle"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        //handle initialization here
        xibInit()
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         //handle initialization here
         xibInit()
     }

    private func xibInit() {
        //style
        //prepare the bundle.
        let bundle = Bundle(for: SchoolListHeaderView.self)
        //load the Xib
        bundle.loadNibNamed("SchoolListHeader", owner: self, options: nil)
        //add the contentView to the stack
    }

    func setup() {
        dateFormatter.dateFormat = "MM/dd/YY hh:mm:ss"
        let todaysDate = dateFormatter.string(from: date)

        header.backgroundColor = .systemFill
        header.translatesAutoresizingMaskIntoConstraints = false

        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal

        nycSchoolsLabel.translatesAutoresizingMaskIntoConstraints = false
        nycSchoolsLabel.font = UIFont(name:"TrebuchetMS-Bold", size: 40.0 )
        nycSchoolsLabel.adjustsFontSizeToFitWidth = true
        nycSchoolsLabel.textAlignment = .left
        nycSchoolsLabel.text = "NYC Schools App"
        nycSchoolsLabel.numberOfLines = 0

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name:"TrebuchetMS", size: 12.0 )
        dateLabel.text = "Data Last Fetched: \(todaysDate)"
        dateLabel.numberOfLines = 0

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit

        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
    }

    func layout() {
        self.addSubview(header)

        header.addSubview(headerStackView)

        labelStackView.addSubview(nycSchoolsLabel)
        labelStackView.addSubview(dateLabel)
        headerStackView.addSubview(labelStackView)
        headerStackView.addSubview(imageView)

        //stack view
        NSLayoutConstraint.activate([
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),


            labelStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.6),
            labelStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            labelStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            labelStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),

            nycSchoolsLabel.widthAnchor.constraint(equalTo: labelStackView.widthAnchor),
            nycSchoolsLabel.topAnchor.constraint(equalTo: labelStackView.topAnchor, constant: 10),
            nycSchoolsLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            nycSchoolsLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.4),

            dateLabel.topAnchor.constraint(equalTo: nycSchoolsLabel.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: labelStackView.widthAnchor),
            dateLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            dateLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.3),

            imageView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: labelStackView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 1),

//            self.heightAnchor.constraint(equalToConstant: 130),

//            headerStackView.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),
//            headerStackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
//            headerStackView.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20),

//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//            imageView.leadingAnchor.constraint(equalTo: headerStackView.trailingAnchor, constant: 80),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])

    }

    override var intrinsicContentSize: CGSize {
        //change the height to what works for you. 140-150 is a pretty good range
        return CGSize(width: UIView.noIntrinsicMetric, height: 150)
    }
}
//
//headerStackView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.6),
//headerStackView.topAnchor.constraint(equalTo: header.topAnchor),
//headerStackView.leftAnchor.constraint(equalTo: header.leftAnchor),
//headerStackView.heightAnchor.constraint(equalTo: header.heightAnchor, multiplier: 0.7),
//headerStackView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
//
//nycSchoolsLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
//nycSchoolsLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
//nycSchoolsLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor, constant: 10),
//
//dateLabel.topAnchor.constraint(equalTo: nycSchoolsLabel.bottomAnchor),
//dateLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
//dateLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
//
//imageView.leftAnchor.constraint(equalTo: headerStackView.rightAnchor, constant: 5),
//imageView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.3),
//imageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
//imageView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.9),
