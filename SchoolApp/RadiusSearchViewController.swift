//
//  RadiusSearchViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class RadiusSearchViewController: UIViewController {
    
    lazy var radiusSearchHeaderView: RadiusSearchHeaderView = {
        var view = RadiusSearchHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    
    lazy var milesText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        textField.delegate = self
        return textField
    }()
    
    lazy var enterButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Search", viewWidth: view.bounds.width, imageName: "magnifyingglass", titleSize: 42, imageSize: 42)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let mapSearchViewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?
    var annotations = [MKPointAnnotation]()
    var location = CLLocation()
    var miles = 1.0
        
    deinit {
        print("radsearchvc")
    }
    init(viewModel: MapSearchViewModel) {
        self.mapSearchViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setup()
        layout()
    }
    
    func setup() {
        map.delegate = self
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                self!.location = location
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02 * self!.miles, longitudeDelta: 0.04 * self!.miles)), animated: true)
                
                self!.mapSearchViewModel.latitude = location.coordinate.latitude
                self!.mapSearchViewModel.longitude = location.coordinate.longitude
                self!.mapSearchViewModel.getSchoolsByMiles()
                self!.setupMap()
            }
        }
    }
    
    func setupMap() {
        for i in mapSearchViewModel.nearbySchools {
            addMapPin(latitude: i.latitude!, longitude: i.longitude!, label: i.school_name)
        }
        map.addAnnotations(annotations)
    }
    
    func addMapPin(latitude: String, longitude: String, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = Double(longitude)!
        pin.coordinate.latitude = Double(latitude)!
        pin.title = label
        
        annotations.append(pin)
    }
    
    func layout() {
        view.addSubview(radiusSearchHeaderView)
        view.addSubview(map)
        
        radiusSearchHeaderView.inputStackView.addSubview(milesText)
        radiusSearchHeaderView.buttonStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            radiusSearchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            radiusSearchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            radiusSearchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            radiusSearchHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: radiusSearchHeaderView.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            milesText.heightAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.heightAnchor, multiplier: 0.7),
            milesText.widthAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.widthAnchor, multiplier: 0.3),
            milesText.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerXAnchor),
            milesText.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerYAnchor),
            
            enterButton.heightAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.heightAnchor, multiplier: 0.6),
            enterButton.widthAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.widthAnchor),
            enterButton.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerYAnchor),
            enterButton.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerXAnchor),
        ])
    }
}

extension RadiusSearchViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        radiusSearchHeaderView.errorLabel.isHidden = true
        
        if Double(milesText.text!) == nil{
            errorHandler(message: "Please Enter A Numerical Value")
            return
        }
        
        if Double(milesText.text!)! > 25 {
            errorHandler(message: "Please Type In A Maximum Value of 25")
            return
        }
        
        if Double(milesText.text!) != nil {
            self.miles = Double(milesText.text!)!
            self.mapSearchViewModel.miles = Double(milesText.text!)!
            self.mapSearchViewModel.getSchoolsByMiles()
            self.map.removeAnnotations(annotations)
            self.annotations = []
            
            self.addMapPin(latitude: String(mapSearchViewModel.latitude), longitude: String(mapSearchViewModel.longitude), label: "CURRENT LOCATION")
            self.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapSearchViewModel.latitude, longitude: mapSearchViewModel.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02 * self.miles, longitudeDelta: 0.04 * self.miles)), animated: true)
            
            self.setupMap()
        }

        func errorHandler(message: String){
            radiusSearchHeaderView.errorLabel.isHidden = false
            radiusSearchHeaderView.errorLabel.text = message
        }
    }
}

extension RadiusSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = mapSearchViewModel.findSchool(name: view.annotation!.title!!)
            
            coordinator?.goToSchoolView(school: mapSearchViewModel.nearbySchools[index], schoolScores: mapSearchViewModel.findSchoolScores(index: index))
//            navigationController?.present(SchoolTabBarViewController(school: mapSearchViewModel.nearbySchools[index], scores: mapSearchViewModel.findSchoolScores(index: index)), animated: true)
        }
    }
    
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

extension RadiusSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        milesText.endEditing(true)
        radiusSearchHeaderView.errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        radiusSearchHeaderView.errorLabel.isHidden = true
    }
}
