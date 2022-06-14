//
//  SchoolListHeader.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation
import UIKit

class SchoolListHeaderView: UIView {
    @IBOutlet var header: UIView!
    let typeLabel = UILabel()
    
    let headerStackView = UIStackView()
    let schoolHeader = UILabel()
    let dateLabel = UILabel()
    
    let date = Date()
    let dateFormatter = DateFormatter()
    
    let imageView = UIImageView(image: UIImage(systemName: "book.circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //handle initialization here
        xibInit()
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         //handle initialization here
         xibInit()
     }
    
    private func xibInit() {
        //style
        //prepare the bundle.
        let bundle = Bundle(for: SchoolListHeaderView.self)
        //load the Xib
        bundle.loadNibNamed("SchoolListHeader", owner: self, options: nil)
        //add the contentView to the stack
    }
    
    func setup() {
        dateFormatter.dateFormat = "MM/dd/YY"
        let x = dateFormatter.string(from: date)
        
        header.backgroundColor = .systemFill
        header.translatesAutoresizingMaskIntoConstraints = false

        schoolHeader.translatesAutoresizingMaskIntoConstraints = false
        schoolHeader.font = UIFont(name:"TrebuchetMS-Bold", size: 40.0 )
        schoolHeader.textAlignment = .left
        schoolHeader.text = "Schools"
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = x
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        headerStackView.spacing = 0
        headerStackView.distribution = .equalSpacing
    }
    
    func layout() {
        addSubview(header)
        
//        NSLayoutConstraint.activate([
//            header.topAnchor.constraint(equalTo: self.topAnchor),
//            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            header.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
        
        headerStackView.addArrangedSubview(schoolHeader)
        headerStackView.addArrangedSubview(dateLabel)
        header.addSubview(headerStackView)
        header.addSubview(imageView)

        //stack view
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),
            headerStackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            headerStackView.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: headerStackView.trailingAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        //change the height to what works for you. 140-150 is a pretty good range
        return CGSize(width: UIView.noIntrinsicMetric, height: 150)
    }
}

