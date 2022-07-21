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
    let numberOfSchools = UILabel()

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
        topSchoolsLabel.text = "Search Schools By Total SAT Score"
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
        
        numberOfSchools.translatesAutoresizingMaskIntoConstraints = false
        numberOfSchools.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        numberOfSchools.adjustsFontSizeToFitWidth = true
        numberOfSchools.textAlignment = .center
        numberOfSchools.text = "# Of Schools"
        numberOfSchools.textColor = .white
        numberOfSchools.numberOfLines = 0
    }

    func layout() {
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(topSchoolsLabel)
        headerStackView.addSubview(filterStackView)
        filterStackView.addSubview(scoreStackView)
        filterStackView.addSubview(numberStackView)
        
        scoreStackView.addSubview(scoreLabel)
        
        numberStackView.addSubview(numberOfSchools)

        NSLayoutConstraint.activate([

            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            topSchoolsLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            topSchoolsLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.4),
            topSchoolsLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            topSchoolsLabel.leftAnchor.constraint(equalTo: headerStackView.leftAnchor),
            
            filterStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor),
            filterStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.5),
            filterStackView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            filterStackView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor),
            
            scoreStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            scoreStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            scoreStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            scoreStackView.leftAnchor.constraint(equalTo: filterStackView.leftAnchor),
            
            numberStackView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 0.3),
            numberStackView.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: 0.45),
            numberStackView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            numberStackView.rightAnchor.constraint(equalTo: filterStackView.rightAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: scoreStackView.topAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: scoreStackView.heightAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.45),
            scoreLabel.leftAnchor.constraint(equalTo: scoreStackView.leftAnchor),
            
            numberOfSchools.topAnchor.constraint(equalTo: numberStackView.topAnchor),
            numberOfSchools.heightAnchor.constraint(equalTo: numberStackView.heightAnchor),
            numberOfSchools.widthAnchor.constraint(equalTo: numberStackView.widthAnchor, multiplier: 0.45),
            numberOfSchools.leftAnchor.constraint(equalTo: numberStackView.leftAnchor)

        ])

    }
}
