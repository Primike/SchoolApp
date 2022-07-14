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
            
        

            schoolScoresTopView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolScoresTopView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            schoolScoresTopView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            
            graphButton.bottomAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.bottomAnchor),
            graphButton.leftAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.leftAnchor),
            graphButton.widthAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.widthAnchor),
            graphButton.heightAnchor.constraint(equalTo: schoolScoresTopView.scoresInfoStackView.heightAnchor, multiplier: 0.3),
            
            
            
            schoolScoresBottomView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolScoresBottomView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.7),
            schoolScoresBottomView.topAnchor.constraint(equalTo: schoolScoresTopView.bottomAnchor),
        ])
    }
}

extension SchoolScoresViewController {
    @objc func graphButtonTapped(sender: UIButton) {
        navigationController?.present(SchoolGraphViewController(school: school, scores: schoolScores, schoolColor: schoolColor), animated: true, completion: nil)
    }
}
