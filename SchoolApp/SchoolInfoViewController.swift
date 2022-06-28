//
//  SchoolInfoController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolInfoViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let screenStackView = UIStackView()

    let buttonBoroStackView = UIStackView()
    let schoolWebsiteButton = UIButton()
    let schoolBoro = UILabel()

    let schoolInfoStackView = UIStackView()
    let schoolName = UILabel()
    let schoolLocation = UILabel()
    let schoolPhone = UILabel()
    
    let schoolImage = UIImageView(image: UIImage(systemName: "book.circle"))
    
    let aboutSubview = UIView()
    let aboutLabel = UILabel()
    let schoolDescription = UILabel()


    let school: School
    let schoolColor: UIColor
    
    init(school: School, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        screenStackView.translatesAutoresizingMaskIntoConstraints = false
        screenStackView.axis = .vertical
        screenStackView.spacing = 3
        
        
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        schoolInfoStackView.axis = .vertical
        schoolInfoStackView.spacing = 5
        
        buttonBoroStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonBoroStackView.axis = .horizontal
        
        schoolWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        schoolWebsiteButton.setTitle("School Website", for: [])
        schoolWebsiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .primaryActionTriggered)
        schoolWebsiteButton.configuration = .filled()
        schoolWebsiteButton.tintColor = schoolColor
        
        schoolBoro.translatesAutoresizingMaskIntoConstraints = false
        schoolBoro.font = UIFont(name:"HelveticaNeue-Bold", size: 60.0)
        schoolBoro.text = "M"
        schoolBoro.adjustsFontSizeToFitWidth = true
        schoolBoro.textColor = schoolColor
        
        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        schoolName.text = school.school_name
        schoolName.numberOfLines = 0
        schoolName.textAlignment = .left
        
        schoolLocation.translatesAutoresizingMaskIntoConstraints = false
        schoolLocation.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        schoolLocation.text = school.location
        schoolLocation.numberOfLines = 0
        schoolLocation.textAlignment = .left
        
        schoolPhone.translatesAutoresizingMaskIntoConstraints = false
        schoolPhone.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        schoolPhone.text = school.phone_number
        schoolPhone.numberOfLines = 0
        schoolPhone.textAlignment = .left

        schoolImage.translatesAutoresizingMaskIntoConstraints = false
        schoolImage.contentMode = .scaleAspectFit
        schoolImage.tintColor = schoolColor
        
        
        
        
        aboutSubview.layer.cornerRadius = 50
        aboutSubview.layer.maskedCorners = [.layerMinXMinYCorner]
        aboutSubview.backgroundColor = schoolColor
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
        aboutLabel.text = "About:"
        aboutLabel.textAlignment = .center
        aboutLabel.textColor = .white
        
        schoolDescription.translatesAutoresizingMaskIntoConstraints = false
        schoolDescription.font = UIFont(name:"HelveticaNeue", size: 18.0)
        schoolDescription.adjustsFontSizeToFitWidth = true
        schoolDescription.text = school.overview_paragraph
        schoolDescription.numberOfLines = 0
        schoolDescription.textAlignment = .left
        schoolDescription.textColor = .white
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(screenStackView)
        
        screenStackView.addArrangedSubview(schoolInfoStackView)
        screenStackView.addArrangedSubview(aboutSubview)
        
        buttonBoroStackView.addSubview(schoolWebsiteButton)
        buttonBoroStackView.addSubview(schoolBoro)
        
        schoolInfoStackView.addSubview(buttonBoroStackView)
        schoolInfoStackView.addSubview(schoolName)
        schoolInfoStackView.addSubview(schoolLocation)
        schoolInfoStackView.addSubview(schoolPhone)
        schoolInfoStackView.addSubview(schoolImage)
    
        
        aboutSubview.addSubview(aboutLabel)
        aboutSubview.addSubview(schoolDescription)
        
        
        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            screenStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            schoolInfoStackView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            
            buttonBoroStackView.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            buttonBoroStackView.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.85),
            buttonBoroStackView.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            buttonBoroStackView.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.15),
            schoolWebsiteButton.leftAnchor.constraint(equalTo: buttonBoroStackView.leftAnchor),
            schoolWebsiteButton.centerYAnchor.constraint(equalTo: buttonBoroStackView.centerYAnchor),
            schoolBoro.rightAnchor.constraint(equalTo: buttonBoroStackView.rightAnchor),
            schoolBoro.centerYAnchor.constraint(equalTo: buttonBoroStackView.centerYAnchor),
            
            
            schoolName.topAnchor.constraint(equalTo: buttonBoroStackView.bottomAnchor, constant: 10),
            schoolName.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.7),
            schoolName.leftAnchor.constraint(equalTo: buttonBoroStackView.leftAnchor),
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor, constant: 10),
            schoolLocation.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.7),
            schoolLocation.leftAnchor.constraint(equalTo: buttonBoroStackView.leftAnchor),
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor, constant: 10),
            schoolPhone.leftAnchor.constraint(equalTo: buttonBoroStackView.leftAnchor),
            schoolImage.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            schoolImage.rightAnchor.constraint(equalTo: schoolInfoStackView.rightAnchor),
            schoolImage.widthAnchor.constraint(equalTo: buttonBoroStackView.widthAnchor, multiplier: 0.45),
            schoolImage.heightAnchor.constraint(equalToConstant: 170),
            
            
            aboutSubview.topAnchor.constraint(equalTo: schoolImage.bottomAnchor, constant: 10),
            aboutSubview.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            aboutSubview.heightAnchor.constraint(equalToConstant: 500),
            
            
            aboutLabel.topAnchor.constraint(equalTo: aboutSubview.topAnchor, constant: 20),
            aboutLabel.leftAnchor.constraint(equalTo: aboutSubview.leftAnchor, constant: 30),
            schoolDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 25),
            schoolDescription.widthAnchor.constraint(equalTo: aboutSubview.widthAnchor, multiplier: 0.9),
            schoolDescription.centerXAnchor.constraint(equalTo: aboutSubview.centerXAnchor),
                
        ])
    }
}

extension SchoolInfoViewController {
    @objc func websiteButtonTapped(sender: UIButton) {
        guard let url = URL(string: "https://\(school.website)") else {
            print("Invalid Url")
            return
        }
        UIApplication.shared.open(url) { success in
            if success {
            } else {
            }
        }
    }
}


