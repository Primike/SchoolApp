//
//  SchoolAppButtonConfiguration.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/20/23.
//

import Foundation
import UIKit

class SchoolAppButtonConfiguration {
    static let configuration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .center
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5.0
        return configuration
    }()
}
