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
    
    lazy var titleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "\(viewModel.school.school_name) Map", labelTextColor: viewModel.getColor(schoolBoro: viewModel.school.boro))
        return label
    }()
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        return map
    }()
    
    let schoolColor: UIColor
    let viewModel: SchoolViewModel
    weak var coordinator: Coordinating?

    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        self.schoolColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        layout()
        setup()
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let userLocation = appDelegate.userLocation,
              let latitude = Double(viewModel.school.latitude!),
              let longitude = Double(viewModel.school.longitude!) else {
            return
        }

        addMapPin(latitude: String(userLocation.coordinate.latitude), longitude: String(userLocation.coordinate.longitude), label: "CURRENT LOCATION")
        addMapPin(latitude: viewModel.school.latitude!, longitude: viewModel.school.longitude!, label: viewModel.school.school_name)

        map.setRegion(MKCoordinateRegion(center: .init(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
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

