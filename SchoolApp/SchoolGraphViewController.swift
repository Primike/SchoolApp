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
    let valuesStackView = UIStackView()
    let label800 = UILabel()
    let label600 = UILabel()
    let label400 = UILabel()
    let label200 = UILabel()
    let label0 = UILabel()
    
    let graphStackView = UIStackView()
    let mathBar = UILabel()
    let writingBar = UILabel()
    let readingBar = UILabel()
    
    let subjectsStackView = UIStackView()
    let mathLabel = UILabel()
    let writingLabel = UILabel()
    let readingLabel = UILabel()

    var school: School
    var schoolScores: SchoolScores
    let schoolColor: UIColor
    var graphHeightValues = [Float]()
    let subjectNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]
    
    init(school: School, scores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolScores = scores
        self.schoolColor = schoolColor
        
        let score1 = Int(scores.sat_math_avg_score)!
        graphHeightValues.append(Float(Double(score1)/Double(800)))
        let score2 = Int(scores.sat_writing_avg_score)!
        graphHeightValues.append(Float(Double(score2)/Double(800)))
        let score3 = Int(scores.sat_critical_reading_avg_score)!
        graphHeightValues.append(Float(Double(score3)/Double(800)))
                
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
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        
        
        valuesStackView.translatesAutoresizingMaskIntoConstraints = false
        valuesStackView.axis = .vertical
        
        label800.translatesAutoresizingMaskIntoConstraints = false
        label800.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label800.text = "800-"
        label800.textAlignment = .center
        label800.adjustsFontSizeToFitWidth = true
        label800.textColor = .black
        
        label600.translatesAutoresizingMaskIntoConstraints = false
        label600.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label600.text = "600-"
        label600.textAlignment = .center
        label600.adjustsFontSizeToFitWidth = true
        label600.textColor = .black
        
        label400.translatesAutoresizingMaskIntoConstraints = false
        label400.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label400.text = "400-"
        label400.textAlignment = .center
        label400.adjustsFontSizeToFitWidth = true
        label400.textColor = .black

        label200.translatesAutoresizingMaskIntoConstraints = false
        label200.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label200.text = "200-"
        label200.textAlignment = .center
        label200.adjustsFontSizeToFitWidth = true
        label200.textColor = .black

        label0.translatesAutoresizingMaskIntoConstraints = false
        label0.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label0.text = "0-"
        label0.textAlignment = .center
        label0.adjustsFontSizeToFitWidth = true
        label0.textColor = .black

        
        
        graphStackView.translatesAutoresizingMaskIntoConstraints = false
        graphStackView.layer.borderWidth = 3
        graphStackView.layer.borderColor = UIColor.black.cgColor
        graphStackView.axis = .horizontal
        graphStackView.backgroundColor = .systemBackground
    
        mathBar.translatesAutoresizingMaskIntoConstraints = false
        mathBar.backgroundColor = schoolColor
        mathBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        mathBar.text = schoolScores.sat_math_avg_score
        mathBar.textAlignment = .center
        mathBar.textColor = .white
        
        writingBar.translatesAutoresizingMaskIntoConstraints = false
        writingBar.backgroundColor = schoolColor
        writingBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        writingBar.text = schoolScores.sat_writing_avg_score
        writingBar.textAlignment = .center
        writingBar.textColor = .white
        
        readingBar.translatesAutoresizingMaskIntoConstraints = false
        readingBar.backgroundColor = schoolColor
        readingBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        readingBar.text = schoolScores.sat_critical_reading_avg_score
        readingBar.textAlignment = .center
        readingBar.textColor = .white
    
        
        

        subjectsStackView.translatesAutoresizingMaskIntoConstraints = false
        subjectsStackView.axis = .horizontal
        
        mathLabel.translatesAutoresizingMaskIntoConstraints = false
        mathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        mathLabel.text = subjectNames[0]
        mathLabel.textAlignment = .center
        mathLabel.adjustsFontSizeToFitWidth = true
        mathLabel.numberOfLines = 0
        mathLabel.textColor = .black

        writingLabel.translatesAutoresizingMaskIntoConstraints = false
        writingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        writingLabel.text = subjectNames[1]
        writingLabel.textAlignment = .center
        writingLabel.adjustsFontSizeToFitWidth = true
        writingLabel.numberOfLines = 0
        writingLabel.textColor = .black

        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        readingLabel.text = subjectNames[2]
        readingLabel.textAlignment = .center
        readingLabel.adjustsFontSizeToFitWidth = true
        readingLabel.numberOfLines = 0
        readingLabel.textColor = .black

    }
    
    func layout() {
        view.addSubview(screenStackView)

        screenStackView.addSubview(schoolName)
        screenStackView.addSubview(topStackView)
        screenStackView.addSubview(subjectsStackView)
        
        topStackView.addSubview(valuesStackView)
        topStackView.addSubview(graphStackView)
        
        valuesStackView.addSubview(label800)
        valuesStackView.addSubview(label600)
        valuesStackView.addSubview(label400)
        valuesStackView.addSubview(label200)
        valuesStackView.addSubview(label0)

        graphStackView.addSubview(mathBar)
        graphStackView.addSubview(writingBar)
        graphStackView.addSubview(readingBar)
        
        subjectsStackView.addSubview(mathLabel)
        subjectsStackView.addSubview(writingLabel)
        subjectsStackView.addSubview(readingLabel)
        
        
        NSLayoutConstraint.activate([
            screenStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            screenStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            screenStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            schoolName.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolName.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            schoolName.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.1),
            schoolName.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            topStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            topStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.9),
            topStackView.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            topStackView.leftAnchor.constraint(equalTo: screenStackView.leftAnchor),
            
            valuesStackView.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            valuesStackView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            valuesStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.1),
            valuesStackView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            
            label800.topAnchor.constraint(equalTo: valuesStackView.topAnchor),
            label800.widthAnchor.constraint(equalTo: valuesStackView.widthAnchor),
            label800.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor, multiplier: 0.05),
            label600.topAnchor.constraint(equalTo: label800.bottomAnchor),
            label600.widthAnchor.constraint(equalTo: valuesStackView.widthAnchor),
            label600.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor, multiplier: 0.4),
            label400.topAnchor.constraint(equalTo: label600.bottomAnchor),
            label400.widthAnchor.constraint(equalTo: valuesStackView.widthAnchor),
            label400.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor, multiplier: 0.1),
            label200.bottomAnchor.constraint(equalTo: label0.topAnchor),
            label200.widthAnchor.constraint(equalTo: valuesStackView.widthAnchor),
            label200.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor, multiplier: 0.4),
            label0.bottomAnchor.constraint(equalTo: valuesStackView.bottomAnchor),
            label0.widthAnchor.constraint(equalTo: valuesStackView.widthAnchor),
            label0.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor, multiplier: 0.05),
            
            
            
            graphStackView.leftAnchor.constraint(equalTo: valuesStackView.rightAnchor),
            graphStackView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            graphStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            graphStackView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            
            mathBar.leftAnchor.constraint(equalTo: graphStackView.leftAnchor, constant: 20),
            mathBar.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            mathBar.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[0])),
            mathBar.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            writingBar.centerXAnchor.constraint(equalTo: graphStackView.centerXAnchor),
            writingBar.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            writingBar.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[1])),
            writingBar.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            readingBar.rightAnchor.constraint(equalTo: graphStackView.rightAnchor, constant: -20),
            readingBar.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            readingBar.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[2])),
            readingBar.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            
            
            
            subjectsStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            subjectsStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.1),
            subjectsStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            subjectsStackView.leftAnchor.constraint(equalTo: screenStackView.leftAnchor),
            
            mathLabel.leftAnchor.constraint(equalTo: mathBar.leftAnchor),
            mathLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            mathLabel.heightAnchor.constraint(equalTo: subjectsStackView.heightAnchor),
            mathLabel.widthAnchor.constraint(equalTo: mathBar.widthAnchor),

            writingLabel.leftAnchor.constraint(equalTo: writingBar.leftAnchor),
            writingLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            writingLabel.heightAnchor.constraint(equalTo: subjectsStackView.heightAnchor),
            writingLabel.widthAnchor.constraint(equalTo: writingBar.widthAnchor),

            readingLabel.leftAnchor.constraint(equalTo: readingBar.leftAnchor),
            readingLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            readingLabel.heightAnchor.constraint(equalTo: subjectsStackView.heightAnchor),
            readingLabel.widthAnchor.constraint(equalTo: readingBar.widthAnchor),
        ])
    }
}
