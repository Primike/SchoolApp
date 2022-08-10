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
    
    let titleLabel = UILabel()
    let map = MKMapView()
    
    let latitude: String
    let longitude: String
    let schoolName: String
    let schoolColor: UIColor

    init(latitude: String, longitude: String, schoolName: String, schoolColor: UIColor) {
        self.latitude = latitude
        self.longitude = longitude
        self.schoolName = schoolName
        self.schoolColor = schoolColor
        
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
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        titleLabel.text = "\(schoolName) Map"
        titleLabel.textColor = schoolColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        
        map.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
        ])
    }

    func setup() {
        map.delegate = self
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                strongSelf.addMapPin(latitude: self!.latitude, longitude: self!.longitude, label: self!.schoolName)

                strongSelf.map.setRegion(MKCoordinateRegion(center: .init(latitude: Double(self!.latitude)!, longitude: Double(self!.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
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

extension SchoolMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         let reuseIdentifier = "annotationView"
         var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
         if #available(iOS 11.0, *) {
             if view == nil {
                 view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
             }
             view?.displayPriority = .required
         } else {
             if view == nil {
                 view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
             }
         }
         view?.annotation = annotation
         view?.canShowCallout = true
         return view
     }
}

