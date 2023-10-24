//
//  MapErrors.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/24/23.
//

import Foundation

enum MapValidation: String, Error {
    case invalidAddress = "Invalid Address Please Try Again"
    case outsideZone = "Please Enter An NYC Address"
}

enum GeocodingError: String, Error {
    case geocodingFailed = "Invalid Address Please Try Again"
    case invalidCoordinates = "Please Enter An NYC Address"
}
