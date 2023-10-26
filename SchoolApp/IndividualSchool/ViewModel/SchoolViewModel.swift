//
//  SchoolViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import CoreLocation
import UIKit

class SchoolViewModel: SchoolColor {
    var schoolData: SchoolData
    
    init(schoolData: SchoolData) {
        self.schoolData = schoolData
    }
    
    var coordinate: CLLocationCoordinate2D? {
        return schoolData.school.coordinates
    }
    
    var websiteURL: URL? {
        return URL(string: "https://\(schoolData.school.website)")
    }
}
