//
//  HomeBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeBottomView: UIView {
    
    let titleView = UIView()
    let appTitleLabel = UILabel()
    let divider = UILabel()
    
    let schoolsListButtonView = UIView()
    let topSchoolsButtonView = UIView()
    let mySchoolsButtonView = UIView()
    let smallButtonsView = UIView()
    
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
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        appTitleLabel.text = "Schools App"
        appTitleLabel.textColor = .white
        appTitleLabel.adjustsFontSizeToFitWidth = true
        appTitleLabel.textAlignment = .center
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        
        schoolsListButtonView.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsButtonView.translatesAutoresizingMaskIntoConstraints = false
        mySchoolsButtonView.translatesAutoresizingMaskIntoConstraints = false
        smallButtonsView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 70
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.backgroundColor = UIColor.white
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .black
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.textAlignment = .center
        
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.backgroundColor = .black
    }
    
    func layout() {
        self.addSubview(titleView)
        self.addSubview(schoolsListButtonView)
        self.addSubview(topSchoolsButtonView)
        self.addSubview(mySchoolsButtonView)
        self.addSubview(smallButtonsView)
        self.addSubview(bottomView)
        
        titleView.addSubview(appTitleLabel)
        titleView.addSubview(divider)
        
        bottomView.addSubview(welcomeLabel)
        bottomView.addSubview(divider2)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor),
            titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            appTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            appTitleLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor, multiplier: 0.7),
            appTitleLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 0.9),
            appTitleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            divider.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 5),
            divider.widthAnchor.constraint(equalTo: titleView.widthAnchor),
            divider.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            schoolsListButtonView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
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
            
            smallButtonsView.topAnchor.constraint(equalTo: mySchoolsButtonView.bottomAnchor),
            smallButtonsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            smallButtonsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            smallButtonsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            bottomView.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            welcomeLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5),
            welcomeLabel.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8),
            welcomeLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            divider2.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 5),
            divider2.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8),
            divider2.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
    }
}
