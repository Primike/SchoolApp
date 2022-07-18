//
//  SchoolMapViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/18/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class SchoolMapViewController: UIViewController {
    
    let map = MKMapView()
    let latitude: String
    let longitude: String
    let schoolName: String

    init(latitude: String, longitude: String, schoolName: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.schoolName = schoolName
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
        
    }
    
    func style() {
//        title = schoolName
        view.backgroundColor = .white
        map.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            
        ])
    }

    func setup() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
                strongSelf.addMapPin(latitude: self!.latitude, longitude: self!.longitude, label: self!.schoolName)
            }
        }
    }
    
    func addMapPin(latitude: String, longitude: String, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = Double(longitude)!
        pin.coordinate.latitude = Double(latitude)!
        pin.title = label
        map.addAnnotation(pin)
    }
}

