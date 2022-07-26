//
//  NearestSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/25/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class NearbySchoolsViewController: UIViewController {
    
    let map = MKMapView()
    let schoolsNumber = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: MapSearchViewModel
    var annotations = [MKPointAnnotation]()
    
    let nearbySchoolsHeaderView = NearbySchoolsHeaderView()
    
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
        
        schoolsNumber.translatesAutoresizingMaskIntoConstraints = false
        schoolsNumber.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        schoolsNumber.font = UIFont(name:"HelveticaNeue", size: 40.0)
        schoolsNumber.adjustsFontSizeToFitWidth = true
        schoolsNumber.textAlignment = .center
        schoolsNumber.layer.borderWidth = 3
        schoolsNumber.layer.cornerRadius = 7.0
        schoolsNumber.textColor = .white
        schoolsNumber.delegate = self
        
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
        
        nearbySchoolsHeaderView.inputStackView.addSubview(schoolsNumber)
        nearbySchoolsHeaderView.buttonStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            nearbySchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nearbySchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            nearbySchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            map.topAnchor.constraint(equalTo: nearbySchoolsHeaderView.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            schoolsNumber.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.heightAnchor, multiplier: 0.7),
            schoolsNumber.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.widthAnchor, multiplier: 0.3),
            schoolsNumber.centerXAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.centerXAnchor),
            schoolsNumber.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.centerYAnchor),
            
            enterButton.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.centerYAnchor),
            enterButton.centerXAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.centerXAnchor),
            enterButton.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.heightAnchor, multiplier: 0.7),
            enterButton.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.widthAnchor, multiplier: 0.8),
        
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

extension NearbySchoolsViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        nearbySchoolsHeaderView.errorLabel.isHidden = true

        if schoolsNumber.text!.isEmpty{
            return
        }
        
        if Int(schoolsNumber.text!) == nil{
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(schoolsNumber.text!)! > nearbySchoolsViewModel.schools.count {
            errorHandler(message: "Please Type In A Value Less Than \(nearbySchoolsViewModel.schools.count)")
            return
        }
        
        if Int(schoolsNumber.text!) != nil{

            self.nearbySchoolsViewModel.number = Int(schoolsNumber.text!)!
            self.nearbySchoolsViewModel.getNearbySchools()
            self.map.removeAnnotations(annotations)
            self.annotations = []
            self.setup()
            
        }

        func errorHandler(message: String){
            nearbySchoolsHeaderView.errorLabel.isHidden = false
            nearbySchoolsHeaderView.errorLabel.text = message
        }
    }
}

extension NearbySchoolsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
            
            navigationController?.pushViewController(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        }
    }
}

extension NearbySchoolsViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        schoolsNumber.endEditing(true)
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

