//
//  NearbySchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class CoordinateSearchHeaderView: UIView {
    
    let headerStackView = UIStackView()
    let coordinatesLabel = UILabel()
    let coordinatesStackView = UIStackView()
    let latitudeStackView = UIStackView()
    let latitudeLabel = UILabel()
    let longitudeStackView = UIStackView()
    let longitudeLabel = UILabel()
    let errorLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func setup() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        coordinatesLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        coordinatesLabel.adjustsFontSizeToFitWidth = true
        coordinatesLabel.textAlignment = .center
        coordinatesLabel.text = "Search Nearby Schools By Coordinates"
        coordinatesLabel.textColor = .white
        coordinatesLabel.numberOfLines = 0
        
        coordinatesStackView.translatesAutoresizingMaskIntoConstraints = false
        coordinatesStackView.axis = .vertical
        
        latitudeStackView.translatesAutoresizingMaskIntoConstraints = false
        latitudeStackView.axis = .horizontal
        
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        latitudeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        latitudeLabel.adjustsFontSizeToFitWidth = true
        latitudeLabel.textAlignment = .center
        latitudeLabel.text = "Latitude"
        latitudeLabel.textColor = .white
        latitudeLabel.numberOfLines = 0
        
        longitudeStackView.translatesAutoresizingMaskIntoConstraints = false
        longitudeStackView.axis = .horizontal
        
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        longitudeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        longitudeLabel.adjustsFontSizeToFitWidth = true
        longitudeLabel.textAlignment = .center
        longitudeLabel.text = "Longitude"
        longitudeLabel.textColor = .white
        longitudeLabel.numberOfLines = 0
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
    }
    
    func layout() {
        self.addSubview(headerStackView)
        headerStackView.addSubview(coordinatesLabel)
        headerStackView.addSubview(coordinatesStackView)
        headerStackView.addSubview(errorLabel)
        
        coordinatesStackView.addSubview(latitudeStackView)
        coordinatesStackView.addSubview(longitudeStackView)
        
        latitudeStackView.addSubview(latitudeLabel)
        longitudeStackView.addSubview(longitudeLabel)
        
        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            coordinatesLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            coordinatesLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            coordinatesLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor),
            coordinatesLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            coordinatesStackView.topAnchor.constraint(equalTo: coordinatesLabel.bottomAnchor),
            coordinatesStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.5),
            coordinatesStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            coordinatesStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            latitudeStackView.topAnchor.constraint(equalTo: coordinatesStackView.topAnchor),
            latitudeStackView.leftAnchor.constraint(equalTo: coordinatesStackView.leftAnchor),
            latitudeStackView.heightAnchor.constraint(equalTo: coordinatesStackView.heightAnchor),
            latitudeStackView.widthAnchor.constraint(equalTo: coordinatesStackView.widthAnchor, multiplier: 0.3),
            
            latitudeLabel.topAnchor.constraint(equalTo: latitudeStackView.topAnchor),
            latitudeLabel.leftAnchor.constraint(equalTo: latitudeStackView.leftAnchor),
            latitudeLabel.heightAnchor.constraint(equalTo: latitudeStackView.heightAnchor),
            latitudeLabel.widthAnchor.constraint(equalTo: latitudeStackView.widthAnchor, multiplier: 0.45),
            
            longitudeStackView.topAnchor.constraint(equalTo: coordinatesStackView.topAnchor),
            longitudeStackView.heightAnchor.constraint(equalTo: coordinatesStackView.heightAnchor),
            longitudeStackView.widthAnchor.constraint(equalTo: coordinatesStackView.widthAnchor, multiplier: 0.3),
            longitudeStackView.centerXAnchor.constraint(equalTo: coordinatesStackView.centerXAnchor),
            
            longitudeLabel.topAnchor.constraint(equalTo: longitudeStackView.topAnchor),
            longitudeLabel.leftAnchor.constraint(equalTo: longitudeStackView.leftAnchor),
            longitudeLabel.heightAnchor.constraint(equalTo: longitudeStackView.heightAnchor),
            longitudeLabel.widthAnchor.constraint(equalTo: longitudeStackView.widthAnchor, multiplier: 0.45),
            
            errorLabel.topAnchor.constraint(equalTo: coordinatesStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.2),
            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.7),
            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
        ])
    }
}
