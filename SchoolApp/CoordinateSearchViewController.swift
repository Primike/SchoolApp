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

class CoordinateSearchViewController: UIViewController {
    
    let map = MKMapView()
    let latitudeText = UITextField()
    let longitudeText = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: MapSearchViewModel
    var nearbySchools = [School]()
    var annotations = [MKPointAnnotation]()
    
    let nearbySchoolsHeaderView = CoordinateSearchHeaderView()
    
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
        
        nearbySchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        nearbySchoolsHeaderView.layer.cornerRadius = 30
        nearbySchoolsHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nearbySchoolsHeaderView.backgroundColor = UIColor.systemBlue
        
        latitudeText.translatesAutoresizingMaskIntoConstraints = false
        latitudeText.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        latitudeText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        latitudeText.adjustsFontSizeToFitWidth = true
        latitudeText.textAlignment = .center
        latitudeText.layer.borderWidth = 3
        latitudeText.layer.cornerRadius = 7.0
        latitudeText.textColor = .white
        latitudeText.delegate = self
        
        longitudeText.translatesAutoresizingMaskIntoConstraints = false
        longitudeText.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        longitudeText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        longitudeText.adjustsFontSizeToFitWidth = true
        longitudeText.textAlignment = .center
        longitudeText.layer.borderWidth = 3
        longitudeText.layer.cornerRadius = 7.0
        longitudeText.textColor = .white
        longitudeText.delegate = self
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.backgroundColor = .black
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitle("Search", for: .normal)
        enterButton.titleLabel!.font = UIFont(name:"HelveticaNeue-bold", size: 20.0)
        enterButton.titleLabel!.adjustsFontSizeToFitWidth = true
        enterButton.layer.cornerRadius = 10
        enterButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        view.addSubview(nearbySchoolsHeaderView)
        view.addSubview(map)
        
        nearbySchoolsHeaderView.latitudeStackView.addSubview(latitudeText)
        nearbySchoolsHeaderView.longitudeStackView.addSubview(longitudeText)
        nearbySchoolsHeaderView.coordinatesStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            nearbySchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nearbySchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            nearbySchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            map.topAnchor.constraint(equalTo: nearbySchoolsHeaderView.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            latitudeText.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.latitudeStackView.centerYAnchor),
            latitudeText.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.latitudeStackView.widthAnchor, multiplier: 0.45),
            latitudeText.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.latitudeStackView.heightAnchor, multiplier: 0.5),
            latitudeText.rightAnchor.constraint(equalTo: nearbySchoolsHeaderView.latitudeStackView.rightAnchor),
            
            longitudeText.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.longitudeStackView.centerYAnchor),
            longitudeText.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.longitudeStackView.widthAnchor, multiplier: 0.45),
            longitudeText.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.longitudeStackView.heightAnchor, multiplier: 0.5),
            longitudeText.rightAnchor.constraint(equalTo: nearbySchoolsHeaderView.longitudeStackView.rightAnchor),
            
            enterButton.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.coordinatesStackView.centerYAnchor),
            enterButton.rightAnchor.constraint(equalTo: nearbySchoolsHeaderView.coordinatesStackView.rightAnchor),
            enterButton.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.coordinatesStackView.heightAnchor, multiplier: 0.6),
            enterButton.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.coordinatesStackView.widthAnchor, multiplier: 0.25),
        
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

extension CoordinateSearchViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        nearbySchoolsHeaderView.errorLabel.isHidden = true

        if latitudeText.text!.isEmpty || longitudeText.text!.isEmpty{
            errorHandler(message: "Insert A Value")
            return
        }
        
        if Double(latitudeText.text!) == nil || Double(longitudeText.text!) == nil{
            errorHandler(message: "Please Enter A Numerical Value")
            return
        }
        
        if Double(latitudeText.text!)! < -90 || Double(latitudeText.text!)! > 90 {
            errorHandler(message: "Latitude Values Range Between -90 And 90")
            return
        }
        
        if Double(longitudeText.text!)! < -180 || Double(longitudeText.text!)! > 180 {
            errorHandler(message: "Longitude Values Range Between -180 And 180")
            return
        }
        
        if Double(latitudeText.text!) != nil && Double(latitudeText.text!) != nil{
            self.nearbySchoolsViewModel.latitude = Double(latitudeText.text!)!
            self.nearbySchoolsViewModel.longitude = Double(longitudeText.text!)!
            self.nearbySchoolsViewModel.getNearbySchools()
            self.map.removeAnnotations(annotations)
            self.annotations = []
            self.setupMap()
            for i in nearbySchoolsViewModel.nearbySchools {
                print(i.school_name)
            }
        }

        func errorHandler(message: String){
            nearbySchoolsHeaderView.errorLabel.isHidden = false
            nearbySchoolsHeaderView.errorLabel.text = message
        }
    }
}

extension CoordinateSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
        
        navigationController?.pushViewController(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        
    }
}

extension CoordinateSearchViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        latitudeText.endEditing(true)
        nearbySchoolsHeaderView.errorLabel.isHidden = true
        return true
    }
    
    //callback to see what's in the text field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nearbySchoolsHeaderView.errorLabel.isHidden = true
    }
}
