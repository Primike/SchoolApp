//
//  HomeBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeBottomView: UIView {
    
    let titleStackView = UIStackView()
    let appTitle = UILabel()
    let divider = UILabel()
    
    let schoolsListButtonView = UIView()
    let topSchoolsButtonView = UIView()
    let mySchoolsButtonView = UIView()
    let extraButtonsView = UIView()
    
    let bottomView = UIView()
    let welcomeLabel = UILabel()
    let divider2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        appTitle.text = "Schools App"
        appTitle.textColor = .white
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        
        schoolsListButtonView.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsButtonView.translatesAutoresizingMaskIntoConstraints = false
        mySchoolsButtonView.translatesAutoresizingMaskIntoConstraints = false
        extraButtonsView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 70
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.backgroundColor = UIColor.white
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .systemRed
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.textAlignment = .center
        
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.backgroundColor = .systemRed
    }
    
    func layout() {
        titleStackView.addSubview(appTitle)
        titleStackView.addSubview(divider)
        
        bottomView.addSubview(welcomeLabel)
        bottomView.addSubview(divider2)
        
        self.addSubview(titleStackView)
        self.addSubview(schoolsListButtonView)
        self.addSubview(topSchoolsButtonView)
        self.addSubview(mySchoolsButtonView)
        self.addSubview(extraButtonsView)
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            titleStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            appTitle.centerYAnchor.constraint(equalTo: titleStackView.centerYAnchor),
            appTitle.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            
            divider.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 10),
            divider.widthAnchor.constraint(equalTo: titleStackView.widthAnchor),
            divider.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            divider.heightAnchor.constraint(equalToConstant: 5),
            
            schoolsListButtonView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            schoolsListButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            schoolsListButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            schoolsListButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            topSchoolsButtonView.topAnchor.constraint(equalTo: schoolsListButtonView.bottomAnchor),
            topSchoolsButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            topSchoolsButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            topSchoolsButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            mySchoolsButtonView.topAnchor.constraint(equalTo: topSchoolsButtonView.bottomAnchor),
            mySchoolsButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            mySchoolsButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            mySchoolsButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            extraButtonsView.topAnchor.constraint(equalTo: mySchoolsButtonView.bottomAnchor),
            extraButtonsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            extraButtonsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            extraButtonsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bottomView.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            welcomeLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5),
            welcomeLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            
            divider2.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 5),
            divider2.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            divider2.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8),
        ])
    }
}
