//
//  ComparisonViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonViewController: UIViewController {
    
    let topStackView = UIStackView()
    var comparisonInfoView: ComparisonInfoView
    let comparisonInfoView2: ComparisonInfoView
    let verticalDivider = UILabel()
    
    var school: School
    var schoolScores: SchoolScores
    var school2: School
    var schoolScores2: SchoolScores
    var schoolColor = UIColor.systemBlue
    
    init(school1: School, scores1: SchoolScores, school2: School, scores2: SchoolScores) {
        self.school = school1
        self.schoolScores = scores1
        self.school2 = school2
        self.schoolScores2 = scores2
        
        self.comparisonInfoView = ComparisonInfoView(frame: CGRect(), school: school, schoolColor: .black)
        self.comparisonInfoView2 = ComparisonInfoView(frame: CGRect(), school: school2, schoolColor: .black)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        comparisonInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        comparisonInfoView2.translatesAutoresizingMaskIntoConstraints = false
        
        verticalDivider.translatesAutoresizingMaskIntoConstraints = false
        verticalDivider.backgroundColor = .black
    }
    
    func layout() {
        view.addSubview(topStackView)
        topStackView.addSubview(comparisonInfoView)
        topStackView.addSubview(verticalDivider)
        topStackView.addSubview(comparisonInfoView2)
        
        NSLayoutConstraint.activate([
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            topStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            comparisonInfoView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            comparisonInfoView.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            comparisonInfoView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            comparisonInfoView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
            
            verticalDivider.topAnchor.constraint(equalTo: topStackView.topAnchor),
            verticalDivider.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            verticalDivider.widthAnchor.constraint(equalToConstant: 5),
            verticalDivider.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor),
            
            comparisonInfoView2.topAnchor.constraint(equalTo: topStackView.topAnchor),
            comparisonInfoView2.rightAnchor.constraint(equalTo: topStackView.rightAnchor),
            comparisonInfoView2.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            comparisonInfoView2.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
        ])
    }
}
