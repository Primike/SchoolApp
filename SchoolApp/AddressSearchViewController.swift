//
//  NearbySchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/17/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddressSearchViewController: UIViewController {
    
    let addressSearchHeaderView = AddressSearchHeaderView()
    let map = MKMapView()
    let schoolsNumber = UITextField()
    let addressText = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: MapSearchViewModel
    var nearbySchools = [School]()
    var annotations = [MKPointAnnotation]()
    var location = CLLocation()
    var latitude = 0.0
    var longitude = 0.0
        
    init(viewModel: MapSearchViewModel) {
        self.nearbySchoolsViewModel = viewModel
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
        map.translatesAutoresizingMaskIntoConstraints = false
        
        addressSearchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        addressSearchHeaderView.backgroundColor = UIColor.systemBlue
        
        schoolsNumber.translatesAutoresizingMaskIntoConstraints = false
        schoolsNumber.font = UIFont(name:"HelveticaNeue", size: 15.0)
        schoolsNumber.adjustsFontSizeToFitWidth = true
        schoolsNumber.textAlignment = .center
        schoolsNumber.layer.borderWidth = 3
        schoolsNumber.layer.cornerRadius = 7.0
        schoolsNumber.textColor = .black
        schoolsNumber.delegate = self
        schoolsNumber.backgroundColor = .white
        
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        addressText.adjustsFontSizeToFitWidth = true
        addressText.textAlignment = .center
        addressText.layer.borderWidth = 3
        addressText.layer.cornerRadius = 7.0
        addressText.textColor = .black
        addressText.delegate = self
        addressText.backgroundColor = .white
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.setTitle("Find", for: .normal)
        enterButton.configuration = .filled()
        enterButton.configuration?.baseBackgroundColor = .black
    }
    
    func layout() {
        view.addSubview(addressSearchHeaderView)
        view.addSubview(map)
        
        addressSearchHeaderView.schoolNumberStackView.addSubview(schoolsNumber)
        addressSearchHeaderView.addressStackView.addSubview(addressText)
        addressSearchHeaderView.addressStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            addressSearchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addressSearchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            addressSearchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addressSearchHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolsNumber.heightAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.heightAnchor),
            schoolsNumber.leftAnchor.constraint(equalTo: addressText.leftAnchor),
            schoolsNumber.widthAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.widthAnchor, multiplier: 0.3),
            schoolsNumber.centerYAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.centerYAnchor),
            
            addressText.heightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.heightAnchor, multiplier: 0.7),
            addressText.widthAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.widthAnchor, multiplier: 0.5),
            addressText.centerXAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerXAnchor),
            addressText.centerYAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerYAnchor),
            
            enterButton.rightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.rightAnchor),
            enterButton.heightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.heightAnchor, multiplier: 0.8),
            enterButton.widthAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.widthAnchor, multiplier: 0.20),
            enterButton.centerYAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerYAnchor),
            
            map.topAnchor.constraint(equalTo: addressSearchHeaderView.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)), animated: true)
                
                self!.nearbySchoolsViewModel.latitude = location.coordinate.latitude
                self!.nearbySchoolsViewModel.longitude = location.coordinate.longitude
                self!.nearbySchoolsViewModel.getNearbySchools()
                self!.setupMap()
            }
        }
    }
    
    func setupMap() {
        for i in nearbySchoolsViewModel.nearbySchools {
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
}

extension AddressSearchViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        addressSearchHeaderView.errorLabel.isHidden = true

        if addressText.text!.isEmpty {
            errorHandler(message: "Insert An Address")
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressText.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            self.latitude = placemark?.location?.coordinate.latitude ?? 0.0
            self.longitude = placemark?.location?.coordinate.longitude ?? 0.0
            
            if self.latitude == 0.0 || self.longitude == 0.0 {
                errorHandler(message: "Invalid Address Please Try Again")
                return
            }
            
            if self.longitude > -73.55 || self.longitude < -74.33 || self.latitude > 41.01 || self.latitude < 40.4 {
                errorHandler(message: "Please Enter An NYC Address")
                return
            }
            
            if self.latitude != 0.0 && self.longitude != 0.0 {
                if Int(self.schoolsNumber.text!) != nil {
                    self.nearbySchoolsViewModel.nearestNumber = Int(self.schoolsNumber.text!)!
                }
                self.nearbySchoolsViewModel.latitude = self.latitude
                self.nearbySchoolsViewModel.longitude = self.longitude
                self.nearbySchoolsViewModel.getNearbySchools()
                self.map.removeAnnotations(self.annotations)
                self.annotations = []
                
                self.addMapPin(latitude: String(self.latitude), longitude: String(self.longitude), label: "CURRENT LOCATION")
                self.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)), animated: true)
                
                self.setupMap()
            }
        }

        func errorHandler(message: String){
            addressSearchHeaderView.errorLabel.isHidden = false
            addressSearchHeaderView.errorLabel.text = message
        }
    }
}

extension AddressSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
            
            navigationController?.present(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        }
    }
}

extension AddressSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressText.endEditing(true)
        addressSearchHeaderView.errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addressSearchHeaderView.errorLabel.isHidden = true
    }
}
