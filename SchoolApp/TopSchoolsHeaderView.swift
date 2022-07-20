//
//  Top10SchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/19/22.
//

import Foundation
import UIKit

class TopSchoolsHeaderView: UIView {

    let headerStackView = UIStackView()
    let topSchoolsLabel = UILabel()

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

        topSchoolsLabel.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsLabel.font = UIFont(name:"TrebuchetMS-Bold", size: 40.0 )
        topSchoolsLabel.adjustsFontSizeToFitWidth = true
        topSchoolsLabel.textAlignment = .center
        topSchoolsLabel.text = "Top Schools By SAT Scores"
        topSchoolsLabel.textColor = .white
        topSchoolsLabel.numberOfLines = 0

    }

    func layout() {
        self.addSubview(topSchoolsLabel)

        NSLayoutConstraint.activate([

            topSchoolsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            topSchoolsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            topSchoolsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            topSchoolsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])

    }
}
