//
//  SchoolInfoController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    let paragraph = UILabel()
    let link = UIButton()
    let stackView = UIStackView()
    let image = UIImageView()
    
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
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "school")
        
        link.translatesAutoresizingMaskIntoConstraints = false
        link.configuration = .filled()
        link.setTitle("School Website", for: [])
        link.addTarget(self, action: #selector(linkButtonTapped), for: .primaryActionTriggered)
        link.tintColor = .systemGray
        
        paragraph.translatesAutoresizingMaskIntoConstraints = false
        paragraph.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        paragraph.adjustsFontSizeToFitWidth = true
        paragraph.text = school.overview_paragraph
        paragraph.numberOfLines = 0
        paragraph.textAlignment = .left
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
    }
    
    func layout() {
        stackView.addSubview(image)
        stackView.addSubview(link)
        stackView.addSubview(paragraph)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            image.topAnchor.constraint(equalTo: stackView.topAnchor),
            image.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            link.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            link.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            link.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            link.rightAnchor.constraint(equalTo: stackView.rightAnchor),

            paragraph.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5),
            paragraph.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
            paragraph.topAnchor.constraint(equalTo: link.bottomAnchor, constant: 10),
            paragraph.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
        ])
    }
    
    func backgroundColor() {
        switch school.boro {
        case "M":
            view.backgroundColor = .systemCyan
        case "X":
            view.backgroundColor = .systemOrange
        case "K":
            paragraph.textColor = .white
            view.backgroundColor = .black
        case "Q":
            view.backgroundColor = .systemBlue
        default:
            view.backgroundColor = .systemBackground
        }
    }
}

extension InfoViewController {
    @objc func linkButtonTapped(sender: UIButton) {
        UIApplication.shared.open(URL(string: school.website)! as URL, options: [:], completionHandler: nil)
    }
    
    @objc func testsButtonTapped(sender: UIButton) {
        print("TER")
        navigationController?.pushViewController(TestsViewController(school: school, tests: tests), animated: true)
    }
}
