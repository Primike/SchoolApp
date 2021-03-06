//
//  TestsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolScoresViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let screenStackView = UIStackView()
    let schoolScoresTopView: SchoolScoresTopView
    let schoolScoresBottomView: SchoolScoresBottomView
    let graphButton = UIButton()
    
    let school: School
    let schoolScores: SchoolScores
    let schoolColor: UIColor
    
    init(school: School, scores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolScores = scores
        self.schoolColor = schoolColor
        schoolScoresTopView = SchoolScoresTopView(frame: CGRect(), school: school, schoolScores: schoolScores, schoolColor: schoolColor)
        schoolScoresBottomView = SchoolScoresBottomView(frame: CGRect(), school: school, schoolScores: schoolScores, schoolColor: schoolColor)

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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        
        screenStackView.translatesAutoresizingMaskIntoConstraints = false
        screenStackView.axis = .vertical
        
        schoolScoresTopView.translatesAutoresizingMaskIntoConstraints = false
        schoolScoresTopView.backgroundColor = schoolColor
        
        graphButton.translatesAutoresizingMaskIntoConstraints = false
        graphButton.setTitle("Scores Graph", for:.normal)
        graphButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        graphButton.configuration = .filled()
        graphButton.tintColor = .white
        graphButton.setTitleColor(.black, for: .normal)
                
        schoolScoresBottomView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(screenStackView)

        screenStackView.addArrangedSubview(schoolScoresTopView)
        screenStackView.addArrangedSubview(schoolScoresBottomView)
        
        schoolScoresTopView.scoresInfoStackView.addSubview(graphButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            schoolScoresTopView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolScoresTopView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            schoolScoresTopView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolScoresTopView.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            graphButton.leftAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.leftAnchor),
            graphButton.bottomAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.bottomAnchor),
            graphButton.heightAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.heightAnchor, multiplier: 0.3),
            graphButton.widthAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.widthAnchor),
            
            schoolScoresBottomView.topAnchor.constraint(equalTo: schoolScoresTopView.bottomAnchor),
            schoolScoresBottomView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.7),
            schoolScoresBottomView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
        ])
    }
}

extension SchoolScoresViewController {
    @objc func graphButtonTapped(sender: UIButton) {
        navigationController?.present(SchoolGraphViewController(school: school, scores: schoolScores, schoolColor: schoolColor), animated: true, completion: nil)
    }
}
