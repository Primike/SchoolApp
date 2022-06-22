//
//  TestGraph.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/7/22.
//

import Foundation
import UIKit

class TestGraphViewController: UIViewController {

    let viewStackView = UIStackView()
    
    let topStackView = UIStackView()
    let valuesStackView = UIStackView()
    let label800 = UILabel()
    let label600 = UILabel()
    let label400 = UILabel()
    let label200 = UILabel()
    let label0 = UILabel()
    let graphStackView = UIStackView()
    let mathBarLabel = UILabel()
    let mathLabel = UILabel()
    let writingBarLabel = UILabel()
    let writingLabel = UILabel()
    let readingBarLabel = UILabel()
    let readingLabel = UILabel()
    
    let bottomStackView = UIStackView()
    let bottomLeftFiller = UIStackView()
    let scoresStackView = UIStackView()
    
    var school: School
    var tests: SchoolScore
    let color: UIColor
    var graph = [Float]()
    let testNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]
    
    init(school: School, tests: SchoolScore, color: UIColor) {
        self.school = school
        self.tests = tests
        self.color = color
        
        let score1 = Int(tests.sat_math_avg_score)!
        graph.append(Float(Double(score1)/Double(800)))
        let score2 = Int(tests.sat_writing_avg_score)!
        graph.append(Float(Double(score2)/Double(800)))
        let score3 = Int(tests.sat_critical_reading_avg_score)!
        graph.append(Float(Double(score3)/Double(800)))
        
        print(graph)
        
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
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "starbackground") ?? UIImage())
        view.backgroundColor = .white
        
        viewStackView.translatesAutoresizingMaskIntoConstraints = false
        viewStackView.axis = .vertical
        
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
    
        mathBarLabel.translatesAutoresizingMaskIntoConstraints = false
        mathBarLabel.backgroundColor = color
        mathBarLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        mathBarLabel.text = tests.sat_math_avg_score
        mathBarLabel.textAlignment = .center
        mathBarLabel.textColor = .white
        
        writingBarLabel.translatesAutoresizingMaskIntoConstraints = false
        writingBarLabel.backgroundColor = color
        writingBarLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        writingBarLabel.text = tests.sat_writing_avg_score
        writingBarLabel.textAlignment = .center
        writingBarLabel.textColor = .white
        
        readingBarLabel.translatesAutoresizingMaskIntoConstraints = false
        readingBarLabel.backgroundColor = color
        readingBarLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        readingBarLabel.text = tests.sat_critical_reading_avg_score
        readingBarLabel.textAlignment = .center
        readingBarLabel.textColor = .white
    
        
        

        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .horizontal
        
        bottomLeftFiller.translatesAutoresizingMaskIntoConstraints = false
        
        scoresStackView.translatesAutoresizingMaskIntoConstraints = false
        scoresStackView.axis = .horizontal
        scoresStackView.backgroundColor = .systemGreen
        
        mathLabel.translatesAutoresizingMaskIntoConstraints = false
        mathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        mathLabel.text = testNames[0]
        mathLabel.textAlignment = .center
        mathLabel.adjustsFontSizeToFitWidth = true
        mathLabel.numberOfLines = 0
        mathLabel.textColor = .black

        writingLabel.translatesAutoresizingMaskIntoConstraints = false
        writingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        writingLabel.text = testNames[1]
        writingLabel.textAlignment = .center
        writingLabel.adjustsFontSizeToFitWidth = true
        writingLabel.numberOfLines = 0
        writingLabel.textColor = .black

        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        readingLabel.text = testNames[2]
        readingLabel.textAlignment = .center
        readingLabel.adjustsFontSizeToFitWidth = true
        readingLabel.numberOfLines = 0
        readingLabel.textColor = .black

    }
    
    func layout() {
        viewStackView.addSubview(topStackView)
        viewStackView.addSubview(bottomStackView)
        view.addSubview(viewStackView)
        
        
        
        topStackView.addSubview(valuesStackView)
        topStackView.addSubview(graphStackView)
        
        valuesStackView.addSubview(label800)
        valuesStackView.addSubview(label600)
        valuesStackView.addSubview(label400)
        valuesStackView.addSubview(label200)
        valuesStackView.addSubview(label0)

        graphStackView.addSubview(mathBarLabel)
        graphStackView.addSubview(writingBarLabel)
        graphStackView.addSubview(readingBarLabel)
        
        
        bottomStackView.addSubview(mathLabel)
        bottomStackView.addSubview(writingLabel)
        bottomStackView.addSubview(readingLabel)
        
        NSLayoutConstraint.activate([
            viewStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            viewStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            viewStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            
            topStackView.widthAnchor.constraint(equalTo: viewStackView.widthAnchor),
            topStackView.heightAnchor.constraint(equalTo: viewStackView.heightAnchor, multiplier: 0.9),
            topStackView.topAnchor.constraint(equalTo: viewStackView.topAnchor),
            topStackView.leftAnchor.constraint(equalTo: viewStackView.leftAnchor),
            
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
            
            mathBarLabel.leftAnchor.constraint(equalTo: graphStackView.leftAnchor, constant: 20),
            mathBarLabel.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            mathBarLabel.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graph[0])),
            mathBarLabel.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            writingBarLabel.centerXAnchor.constraint(equalTo: graphStackView.centerXAnchor),
            writingBarLabel.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            writingBarLabel.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graph[0])),
            writingBarLabel.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            readingBarLabel.rightAnchor.constraint(equalTo: graphStackView.rightAnchor, constant: -20),
            readingBarLabel.bottomAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            readingBarLabel.heightAnchor.constraint(equalTo: graphStackView.heightAnchor, multiplier: CGFloat(graph[0])),
            readingBarLabel.widthAnchor.constraint(equalTo: graphStackView.widthAnchor, multiplier: 0.25),
            
            
            
            
            bottomStackView.widthAnchor.constraint(equalTo: viewStackView.widthAnchor),
            bottomStackView.heightAnchor.constraint(equalTo: viewStackView.heightAnchor, multiplier: 0.1),
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            bottomStackView.leftAnchor.constraint(equalTo: viewStackView.leftAnchor),
            
            mathLabel.leftAnchor.constraint(equalTo: mathBarLabel.leftAnchor),
            mathLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            mathLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor),
            mathLabel.widthAnchor.constraint(equalTo: mathBarLabel.widthAnchor),

            writingLabel.leftAnchor.constraint(equalTo: writingBarLabel.leftAnchor),
            writingLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            writingLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor),
            writingLabel.widthAnchor.constraint(equalTo: writingBarLabel.widthAnchor),

            readingLabel.leftAnchor.constraint(equalTo: readingBarLabel.leftAnchor),
            readingLabel.topAnchor.constraint(equalTo: graphStackView.bottomAnchor),
            readingLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor),
            readingLabel.widthAnchor.constraint(equalTo: readingBarLabel.widthAnchor),
        ])
    }
}
