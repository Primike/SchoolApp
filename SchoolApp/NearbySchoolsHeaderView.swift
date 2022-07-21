//
//  NearbySchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class NearbySchoolsHeaderView: UIView {
    
    let headerStackView = UIStackView()
    let coordinatesLabel = UILabel()
    let coordinatesStackView = UIStackView()
    let latitudeStackView = UIStackView()
    let latitude = UILabel()
    let longitudeStackView = UIStackView()
    let longitude = UILabel()
    
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
        
        latitude.translatesAutoresizingMaskIntoConstraints = false
        latitude.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        latitude.adjustsFontSizeToFitWidth = true
        latitude.textAlignment = .center
        latitude.text = "Latitude"
        latitude.textColor = .white
        latitude.numberOfLines = 0
        
        longitudeStackView.translatesAutoresizingMaskIntoConstraints = false
        longitudeStackView.axis = .horizontal
        
        longitude.translatesAutoresizingMaskIntoConstraints = false
        longitude.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        longitude.adjustsFontSizeToFitWidth = true
        longitude.textAlignment = .center
        longitude.text = "Longitude"
        longitude.textColor = .white
        longitude.numberOfLines = 0

    }
    
    func layout() {
        self.addSubview(headerStackView)
        headerStackView.addSubview(coordinatesLabel)
        headerStackView.addSubview(coordinatesStackView)
        
        coordinatesStackView.addSubview(latitudeStackView)
        coordinatesStackView.addSubview(longitudeStackView)
        
        latitudeStackView.addSubview(latitude)
        longitudeStackView.addSubview(longitude)
        
        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            coordinatesLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            coordinatesLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor),
            coordinatesLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            coordinatesLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            
            coordinatesStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.5),
            coordinatesStackView.topAnchor.constraint(equalTo: coordinatesLabel.bottomAnchor),
            coordinatesStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            coordinatesStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            latitudeStackView.heightAnchor.constraint(equalTo: coordinatesStackView.heightAnchor),
            latitudeStackView.widthAnchor.constraint(equalTo: coordinatesStackView.widthAnchor, multiplier: 0.3),
            latitudeStackView.leftAnchor.constraint(equalTo: coordinatesStackView.leftAnchor),
            latitudeStackView.topAnchor.constraint(equalTo: coordinatesStackView.topAnchor),
            
            latitude.heightAnchor.constraint(equalTo: latitudeStackView.heightAnchor),
            latitude.widthAnchor.constraint(equalTo: latitudeStackView.widthAnchor, multiplier: 0.45),
            latitude.leftAnchor.constraint(equalTo: latitudeStackView.leftAnchor),
            latitude.topAnchor.constraint(equalTo: latitudeStackView.topAnchor),
            
            longitudeStackView.heightAnchor.constraint(equalTo: coordinatesStackView.heightAnchor),
            longitudeStackView.widthAnchor.constraint(equalTo: coordinatesStackView.widthAnchor, multiplier: 0.3),
            longitudeStackView.topAnchor.constraint(equalTo: coordinatesStackView.topAnchor),
            longitudeStackView.centerXAnchor.constraint(equalTo: coordinatesStackView.centerXAnchor),
            
            longitude.heightAnchor.constraint(equalTo: longitudeStackView.heightAnchor),
            longitude.widthAnchor.constraint(equalTo: longitudeStackView.widthAnchor, multiplier: 0.45),
            longitude.leftAnchor.constraint(equalTo: longitudeStackView.leftAnchor),
            longitude.topAnchor.constraint(equalTo: longitudeStackView.topAnchor),
    
        ])
    }
}
