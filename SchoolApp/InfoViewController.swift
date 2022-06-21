//
//  SchoolInfoController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    let link = UIButton()
    let schoolName = UILabel()
    let schoolLocation = UILabel()
    let schoolPhone = UILabel()
    let infoStackView = UIStackView()
    let about = UILabel()
    let boroLabel = UILabel()
    let topStackView = UIStackView()
    
    let schoolDescription = UILabel()

    let stackView = UIStackView()
    let schoolImage = UIImageView(image: UIImage(systemName: "house.circle.fill"))
    let scrollView = UIScrollView()
    let subview = UIView()

    
    var school: School
    var tests: SchoolScore
    var testScores = [Int]()
    
    init(school: School, tests: SchoolScore) {
        self.school = school
        self.tests = tests
        if tests.sat_math_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_math_avg_score)!)
        }
        if tests.sat_writing_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_writing_avg_score)!)
        }
        if tests.sat_critical_reading_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_critical_reading_avg_score)!)
        }
        print(testScores)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        backgroundColor()
    }
    
    @objc func linkButtonTapped(sender: UIButton) {
        print("website link tapped")
        UIApplication.shared.open(URL(string: school.website)! as URL, options: [:], completionHandler: nil)
    }
    
    func style() {
        
        stackView.backgroundColor = UIColor(patternImage: UIImage(named: "starbackground") ?? UIImage())
        
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("School Website", for: [])
        link.addTarget(self, action: #selector(linkButtonTapped), for: .primaryActionTriggered)
        link.configuration = .filled()
        
        boroLabel.translatesAutoresizingMaskIntoConstraints = false
        boroLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 60.0)
        boroLabel.text = "M"
        boroLabel.adjustsFontSizeToFitWidth = true
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        
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
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 5
        
        schoolImage.translatesAutoresizingMaskIntoConstraints = false
        schoolImage.contentMode = .scaleAspectFit
        
        about.translatesAutoresizingMaskIntoConstraints = false
        about.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
        about.text = "About:"
        about.textAlignment = .center
        about.textColor = .white
        
        schoolDescription.translatesAutoresizingMaskIntoConstraints = false
        schoolDescription.font = UIFont(name:"HelveticaNeue", size: 15.0)
        schoolDescription.adjustsFontSizeToFitWidth = true
        schoolDescription.text = school.overview_paragraph
        schoolDescription.numberOfLines = 0
        schoolDescription.textAlignment = .left
        schoolDescription.textColor = .white
        
        subview.backgroundColor = UIColor.systemBlue
        subview.layer.cornerRadius = 50
        subview.layer.maskedCorners = [.layerMinXMinYCorner]
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
        topStackView.addSubview(link)
        topStackView.addSubview(boroLabel)
        infoStackView.addSubview(topStackView)
        infoStackView.addSubview(schoolName)
        infoStackView.addSubview(schoolLocation)
        infoStackView.addSubview(schoolPhone)
        infoStackView.addSubview(schoolImage)
    
        subview.addSubview(about)
        subview.addSubview(schoolDescription)
        
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(subview)
        scrollView.addSubview(stackView)
        
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            infoStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            topStackView.topAnchor.constraint(equalTo: infoStackView.topAnchor),
            topStackView.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.85),
            topStackView.centerXAnchor.constraint(equalTo: infoStackView.centerXAnchor),
            topStackView.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.15),
            link.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            link.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor),
            boroLabel.rightAnchor.constraint(equalTo: topStackView.rightAnchor),
            boroLabel.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor),
            
            
            schoolName.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            schoolName.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.7),
            schoolName.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor, constant: 10),
            schoolLocation.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.7),
            schoolLocation.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor, constant: 10),
            schoolPhone.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            schoolImage.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            schoolImage.rightAnchor.constraint(equalTo: infoStackView.rightAnchor),
            schoolImage.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
            schoolImage.heightAnchor.constraint(equalToConstant: 170),
            
            
            subview.topAnchor.constraint(equalTo: schoolImage.bottomAnchor, constant: 10),
            subview.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            subview.heightAnchor.constraint(equalToConstant: 400),
            
            
            about.topAnchor.constraint(equalTo: subview.topAnchor, constant: 20),
            about.leftAnchor.constraint(equalTo: subview.leftAnchor, constant: 30),
            schoolDescription.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 25),
            schoolDescription.widthAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 0.9),
            schoolDescription.centerXAnchor.constraint(equalTo: subview.centerXAnchor),
                
        ])
    }
    
    func backgroundColor() {
        switch school.boro {
        case "M":
            boroLabel.textColor = .systemGray
        case "X":
            boroLabel.textColor = .systemOrange
        case "K":
            boroLabel.textColor = .black
        case "Q":
            boroLabel.textColor = UIColor.blue
        default:
            boroLabel.textColor = .systemGreen
        }
    }
}

extension InfoViewController {

}


