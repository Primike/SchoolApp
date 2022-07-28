//
//  SearchSATScoresView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchScoresHeaderView: UIView {

    let headerStackView = UIStackView()
    let topSchoolsLabel = UILabel()
    let filterStackView = UIStackView()
    let scoreStackView = UIStackView()
    let scoreLabel = UILabel()
    let numberStackView = UIStackView()
    let numberOfSchoolsLabel = UILabel()

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
        topSchoolsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        topSchoolsLabel.adjustsFontSizeToFitWidth = true
        topSchoolsLabel.textAlignment = .center
        topSchoolsLabel.text = "Search Schools By SAT Score"
        topSchoolsLabel.textColor = .white
        topSchoolsLabel.numberOfLines = 0
        
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        filterStackView.axis = .vertical

        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        scoreStackView.axis = .horizontal
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score"
        scoreLabel.textColor = .white
        scoreLabel.numberOfLines = 0
        
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        numberStackView.axis = .horizontal
        
        numberOfSchoolsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfSchoolsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        numberOfSchoolsLabel.adjustsFontSizeToFitWidth = true
        numberOfSchoolsLabel.textAlignment = .center
        numberOfSchoolsLabel.text = "# Of Schools"
        numberOfSchoolsLabel.textColor = .white
        numberOfSchoolsLabel.numberOfLines = 0
    }

    func layout() {
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(topSchoolsLabel)
        headerStackView.addSubview(filterStackView)
        filterStackView.addSubview(scoreStackView)
        filterStackView.addSubview(numberStackView)
        
        scoreStackView.addSubview(scoreLabel)
        
        numberStackView.addSubview(numberOfSchoolsLabel)

        NSLayoutConstraint.activate([

            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            topSchoolsLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            topSchoolsLabel.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            topSchoolsLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            topSchoolsLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.4),
            
            filterStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            filterStackView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            filterStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            filterStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.5),
            
            scoreStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            scoreStackView.leftAnchor.constraint(equalTo: filterStackView.leftAnchor),
            scoreStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            scoreStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            
            numberStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            numberStackView.rightAnchor.constraint(equalTo: filterStackView.rightAnchor),
            numberStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            numberStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            
            scoreLabel.topAnchor.constraint(equalTo: scoreStackView.topAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: scoreStackView.leftAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: scoreStackView.heightAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.45),
            
            numberOfSchoolsLabel.topAnchor.constraint(equalTo: numberStackView.topAnchor),
            numberOfSchoolsLabel.leftAnchor.constraint(equalTo: numberStackView.leftAnchor),
            numberOfSchoolsLabel.heightAnchor.constraint(equalTo: numberStackView.heightAnchor),
            numberOfSchoolsLabel.widthAnchor.constraint(equalTo: numberStackView.widthAnchor, multiplier: 0.45),
        ])

    }
}
