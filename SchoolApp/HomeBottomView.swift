//
//  HomeBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeBottomView: UIView {
    
    lazy var titleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var appTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.text = "Schools App"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var divider: UILabel = {
        var divider = UILabel()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    lazy var schoolsListButtonView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mapSearchButtonView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mySchoolsButtonView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var smallButtonsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 70
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.text = "Welcome"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var divider2: UILabel = {
        var divider = UILabel()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        return divider
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(titleView)
        self.addSubview(schoolsListButtonView)
        self.addSubview(mapSearchButtonView)
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
            
            mapSearchButtonView.topAnchor.constraint(equalTo: schoolsListButtonView.bottomAnchor),
            mapSearchButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            mapSearchButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            mapSearchButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            mySchoolsButtonView.topAnchor.constraint(equalTo: mapSearchButtonView.bottomAnchor),
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
