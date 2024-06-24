//
//  MapFilterViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit
import MapKit

protocol MapFilterDelegate: AnyObject {
    func filterApplied(miles: Float, coordinates: CLLocationCoordinate2D)
}

class MapFilterViewController: UIViewController {
    
    weak var coordinator: MapSearchCoordinator?
    weak var delegate: MapFilterDelegate?
    private let viewModel: MapSearchViewModel
    let schoolsNumber = ["All"] + Array(1...50).map { String($0) }

    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var filterView: MapFilterView = {
        var view = MapFilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setup()
        layout()
    }
    
    // MARK: - Data For Pickers
    var pickerData: [String] {
        switch filterView.segmentedControl.selectedSegmentIndex {
        case 0:
            return ["Any", "600", "800", "1000", "1200", "1400", "1800", "2000"]
        default:
            return ["0", "200", "300", "400", "500", "600", "700"]
        }
    }
    
    private func setup() {
        filterView.milesSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        filterView.numberPicker.dataSource = self
        filterView.numberPicker.delegate = self
        filterView.minScorePicker.dataSource = self
        filterView.minScorePicker.delegate = self
        
        filterView.applyButton.addTarget(self, action: #selector(applyTouched), for: .touchDown)
        filterView.applyButton.addTarget(self, action: #selector(applyTapped), for: [.touchUpInside, .touchUpOutside])
        
        filterView.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    private func layout() {
        view.addSubview(filterView)
                
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75),
            filterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }
    
    // MARK: - Shows alert for bad address
    private func showAlert() {
        let alert = UIAlertController(title: "Invalid Address", message: "", preferredStyle: .alert)
        
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }

    // MARK: - Filter Options Functions
    @objc func sliderValueChanged(_ sender: UISlider) {
        filterView.milesLabel.text = "\(Int(sender.value)) Miles"
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        filterView.minScorePicker.reloadAllComponents()
    }

    @objc func applyTouched() {
        UIView.animate(withDuration: 0.1) {
            self.filterView.applyButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }

    @objc func applyTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.filterView.applyButton.transform = CGAffineTransform.identity
        }

        let address = filterView.addressText.text ?? ""
        let miles = filterView.milesSlider.value
        let schools = schoolsNumber[filterView.numberPicker.selectedRow(inComponent: 0)]
        let score = pickerData[filterView.minScorePicker.selectedRow(inComponent: 0)]
        let section = filterView.segmentedControl.selectedSegmentIndex
        
        viewModel.validateAddress(address: address, radius: miles) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let coordinates):
                self.viewModel.filterByCoordinates(coordinates: coordinates, miles: Double(miles))
                self.viewModel.filterBySATData(selectedSegment: section, score: score, count: schools)
                
                self.delegate?.filterApplied(miles: miles, coordinates: coordinates)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
                showAlert()
            }
        }
    }
}

extension MapFilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == filterView.numberPicker {
            return schoolsNumber.count
        } else {
            return pickerData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == filterView.numberPicker {
            return schoolsNumber[row]
        } else {
            return pickerData[row]
        }
    }
}
