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

    let topButtonsStackView = UIStackView()
    let schoolWebsiteButton = UIButton()
    let schoolBoro = UILabel()
    let addSchoolButton = UIButton()

    let schoolInfoStackView = UIStackView()
    let schoolName = UILabel()
    let schoolLocation = UILabel()
    let schoolPhone = UILabel()
    
    let schoolImage = UIImageView(image: UIImage(systemName: "book.circle"))
    
    let aboutSubview = UIView()
    let aboutLabel = UILabel()
    let schoolDescription = UILabel()

    let defaults = UserDefaults.standard
    var addButtonImage: String
    let school: School
    let schoolColor: UIColor
    
    init(school: School, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
                
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()
        
        if savedArray.contains(school.dbn) {
            addButtonImage = "checkmark"
        } else {
            addButtonImage = "plus.circle"
        }
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
        
        
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        schoolInfoStackView.axis = .vertical
        
        topButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        topButtonsStackView.axis = .horizontal
        
        schoolWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        schoolWebsiteButton.setTitle("School Website", for: [])
        schoolWebsiteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        schoolWebsiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .primaryActionTriggered)
        schoolWebsiteButton.configuration = .filled()
        schoolWebsiteButton.tintColor = schoolColor
        
        addSchoolButton.translatesAutoresizingMaskIntoConstraints = false
        addSchoolButton.addTarget(self, action: #selector(addSchool), for: .primaryActionTriggered)
        addSchoolButton.tintColor = schoolColor
        addSchoolButton.titleLabel!.adjustsFontSizeToFitWidth = true
        addSchoolButton.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)

        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.text = school.school_name
        schoolName.numberOfLines = 0
        schoolName.textAlignment = .left
        
        schoolLocation.translatesAutoresizingMaskIntoConstraints = false
        schoolLocation.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolLocation.adjustsFontSizeToFitWidth = true
        schoolLocation.text = school.location
        schoolLocation.numberOfLines = 0
        schoolLocation.textAlignment = .left
        
        schoolPhone.translatesAutoresizingMaskIntoConstraints = false
        schoolPhone.adjustsFontSizeToFitWidth = true
        schoolPhone.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolPhone.text = school.phone_number
        schoolPhone.numberOfLines = 0
        schoolPhone.textAlignment = .left

        schoolImage.translatesAutoresizingMaskIntoConstraints = false
        schoolImage.contentMode = .scaleAspectFit
        schoolImage.tintColor = schoolColor
        
        
        
        aboutSubview.translatesAutoresizingMaskIntoConstraints = false
        aboutSubview.layer.cornerRadius = 50
        aboutSubview.layer.maskedCorners = [.layerMinXMinYCorner]
        aboutSubview.backgroundColor = schoolColor
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.font = UIFont(name:"HelveticaNeue-Bold", size:100.0)
        aboutLabel.text = "About:"
        aboutLabel.adjustsFontSizeToFitWidth = true
        aboutLabel.textAlignment = .center
        aboutLabel.textColor = .white
        aboutLabel.baselineAdjustment = .alignCenters
        
        schoolDescription.translatesAutoresizingMaskIntoConstraints = false
        schoolDescription.font = UIFont(name:"HelveticaNeue", size: 100.0)
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
        
        topButtonsStackView.addSubview(schoolWebsiteButton)
        topButtonsStackView.addSubview(addSchoolButton)
        
        schoolInfoStackView.addSubview(topButtonsStackView)
        schoolInfoStackView.addSubview(schoolName)
        schoolInfoStackView.addSubview(schoolLocation)
        schoolInfoStackView.addSubview(schoolPhone)
        schoolInfoStackView.addSubview(schoolImage)
    
        aboutSubview.addSubview(aboutLabel)
        aboutSubview.addSubview(schoolDescription)
        
        NSLayoutConstraint.activate([

            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
            
            schoolInfoStackView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.5),
            
            topButtonsStackView.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            topButtonsStackView.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.9),
            topButtonsStackView.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            topButtonsStackView.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.2),
            schoolWebsiteButton.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolWebsiteButton.centerYAnchor.constraint(equalTo: topButtonsStackView.centerYAnchor),
            schoolWebsiteButton.widthAnchor.constraint(equalTo: topButtonsStackView.widthAnchor, multiplier: 0.5),
            addSchoolButton.rightAnchor.constraint(equalTo: topButtonsStackView.rightAnchor),
            addSchoolButton.centerYAnchor.constraint(equalTo: topButtonsStackView.centerYAnchor),
            addSchoolButton.heightAnchor.constraint(equalTo: topButtonsStackView.heightAnchor),
            addSchoolButton.widthAnchor.constraint(equalTo: topButtonsStackView.heightAnchor),
            
            
            schoolName.topAnchor.constraint(equalTo: topButtonsStackView.bottomAnchor),
            schoolName.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.8),
            schoolName.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolName.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.3),
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            schoolLocation.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.8),
            schoolLocation.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolLocation.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.05),
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor),
            schoolPhone.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolPhone.widthAnchor.constraint(equalTo: schoolInfoStackView.widthAnchor, multiplier: 0.5),
            schoolPhone.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.05),
            schoolImage.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            schoolImage.rightAnchor.constraint(equalTo: addSchoolButton.rightAnchor),
            schoolImage.widthAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.4),
            schoolImage.heightAnchor.constraint(equalTo: schoolInfoStackView.heightAnchor, multiplier: 0.4),
            
            
            aboutSubview.topAnchor.constraint(equalTo: schoolInfoStackView.bottomAnchor),
            aboutSubview.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            aboutSubview.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.5),


            aboutLabel.topAnchor.constraint(equalTo: aboutSubview.topAnchor, constant: 10),
            aboutLabel.leftAnchor.constraint(equalTo: schoolPhone.leftAnchor),
            aboutLabel.heightAnchor.constraint(equalTo: aboutSubview.heightAnchor, multiplier: 0.15),
            aboutLabel.widthAnchor.constraint(equalTo: aboutSubview.widthAnchor, multiplier: 0.25),
            schoolDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor),
            schoolDescription.widthAnchor.constraint(equalTo: aboutSubview.widthAnchor, multiplier: 0.9),
            schoolDescription.centerXAnchor.constraint(equalTo: aboutSubview.centerXAnchor),
            schoolDescription.heightAnchor.constraint(equalTo: aboutSubview.heightAnchor, multiplier: 0.75)
                
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
    
    @objc func addSchool(sender: UIButton) {
        var savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        if addButtonImage == "plus.circle" {
            addButtonImage = "checkmark"
            addSchoolButton.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
            
            savedArray.append(school.dbn)
            defaults.set(savedArray, forKey: "array")
            
        } else {
            addButtonImage = "plus.circle"
            addSchoolButton.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
            
            defaults.set(savedArray.filter { $0 != school.dbn }, forKey: "array")
        }
    }
}


