//
//  MapFilterViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit

class MapFilterViewController: UIViewController {
    
    let pickerData: [Int] = Array(1...100)
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?

    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var addressStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Address:"
        return label
    }()
    
    let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return button
    }()

    lazy var addressText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .body).pointSize
        textField.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .left
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 7.0
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.isEnabled = false
        return textField
    }()
    
    lazy var milesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "5 Miles"
        return label
    }()

    lazy var milesSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var schoolNumberStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var maxNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Number Of Schools"
        return label
    }()
    
    lazy var numberPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Combined", "Math", "Reading", "Writing"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .white
        return segmentedControl
    }()
    
    lazy var minScoreStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var minScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Minimum Score:"
        return label
    }()
    
    lazy var minScorePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        layout()
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(addressStackView)
        addressStackView.addArrangedSubview(addressLabel)
        addressStackView.addArrangedSubview(checkboxButton)
        stackView.addArrangedSubview(addressText)
        stackView.addArrangedSubview(milesLabel)
        stackView.addArrangedSubview(milesSlider)
        stackView.addArrangedSubview(schoolNumberStackView)
        schoolNumberStackView.addArrangedSubview(maxNumberLabel)
        schoolNumberStackView.addArrangedSubview(numberPicker)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(minScoreStackView)
        minScoreStackView.addArrangedSubview(minScoreLabel)
        minScoreStackView.addArrangedSubview(minScorePicker)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let intValue = Int(sender.value)
        milesLabel.text = "\(intValue) Miles"
    }
    
    @objc func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()  // This will toggle between selected and unselected states
    }
}

extension MapFilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle picker selection
        let selectedNumber = pickerData[row]
        print("Selected number: \(selectedNumber)")
    }

}
