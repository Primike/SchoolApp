//
//  TestGraph.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/7/22.
//

import Foundation
import UIKit

class SchoolGraphViewController: UIViewController {

    let screenStackView = UIStackView()
    
    let schoolName = UILabel()
    let topStackView = UIStackView()
    let arrowImage = UIImageView(image: UIImage(systemName: "arrow.down"))
    
    let yAxisView = YAxisView()
    let graphBarsView: GraphBarsView
    let xAxisView = XAxisView()


    var school: School
    var schoolScores: SchoolScores
    let schoolColor: UIColor

    
    init(school: School, scores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolScores = scores
        self.schoolColor = schoolColor
        graphBarsView = GraphBarsView(frame: CGRect(), scores: scores, schoolColor: schoolColor)
        
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
        view.backgroundColor = .white
        
        screenStackView.translatesAutoresizingMaskIntoConstraints = false
        screenStackView.axis = .vertical
        
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        schoolName.text = school.school_name
        schoolName.textColor = schoolColor
        schoolName.textAlignment = .center
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.numberOfLines = 0
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.tintColor = .black
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        
        yAxisView.translatesAutoresizingMaskIntoConstraints = false
        
        graphBarsView.translatesAutoresizingMaskIntoConstraints = false
        graphBarsView.layer.borderWidth = 3
        graphBarsView.layer.borderColor = UIColor.black.cgColor
        graphBarsView.backgroundColor = .systemBackground
    
        
        xAxisView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(screenStackView)

        screenStackView.addSubview(arrowImage)
        screenStackView.addSubview(schoolName)
        screenStackView.addSubview(topStackView)
        screenStackView.addSubview(xAxisView)
        
        topStackView.addSubview(yAxisView)
        topStackView.addSubview(graphBarsView)
        
        
        NSLayoutConstraint.activate([
            screenStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            screenStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            screenStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            arrowImage.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            arrowImage.widthAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            arrowImage.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            arrowImage.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            schoolName.topAnchor.constraint(equalTo: arrowImage.bottomAnchor),
            schoolName.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            schoolName.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.1),
            schoolName.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            
            topStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            topStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.8),
            topStackView.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            topStackView.leftAnchor.constraint(equalTo: screenStackView.leftAnchor),
            
            yAxisView.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            yAxisView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            yAxisView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.1),
            yAxisView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            
            graphBarsView.leftAnchor.constraint(equalTo: yAxisView.rightAnchor),
            graphBarsView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            graphBarsView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            graphBarsView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            

            
            xAxisView.widthAnchor.constraint(equalTo: graphBarsView.widthAnchor),
            xAxisView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            xAxisView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            xAxisView.leftAnchor.constraint(equalTo: graphBarsView.leftAnchor),
        ])
    }
}
