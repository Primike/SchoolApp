//
//  Top10SchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class Top10SchoolsHeaderView: UIView {

    let headerStackView = UIStackView()
    let top10Label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }



    func setup() {

        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal

        top10Label.translatesAutoresizingMaskIntoConstraints = false
        top10Label.font = UIFont(name:"TrebuchetMS-Bold", size: 40.0 )
        top10Label.adjustsFontSizeToFitWidth = true
        top10Label.textAlignment = .center
        top10Label.text = "Top Schools By SAT Scores"
        top10Label.textColor = .white
        top10Label.numberOfLines = 0

    }

    func layout() {
        self.addSubview(top10Label)

        NSLayoutConstraint.activate([

            top10Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            top10Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            top10Label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            top10Label.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])

    }
}
