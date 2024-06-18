//
//  AboutViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/26/23.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    private let text = """
    This is an app which uses NYC high school data.
    
    
    Privacy Policy:

    NYC High School Hunt does not collect, store, or share any personal information.
    Our app is designed to display information from an external API.
    It does not require any user data to function.

    If you have any questions or concerns, please contact us at mkingqwe@yahoo.com.
    
    Read our full privacy policy [here].
    """

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.attributedText = createAttributedText()
        textView.isEditable = false
        textView.dataDetectorTypes = [.link]
        textView.textAlignment = .left
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        view.backgroundColor = .white
        navigationItem.title = "About"
    }
    
    private func layout() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalTo: view.heightAnchor),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func createAttributedText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        let linkRange = (text as NSString).range(of: "here")
        let linkURL = URL(string: "https://primike.com/privatepolicy")!
        
        attributedString.addAttribute(.link, value: linkURL, range: linkRange)
        
        return attributedString
    }
}
