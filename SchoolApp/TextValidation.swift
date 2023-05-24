//
//  TextValidation.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/24/23.
//

import Foundation

enum InputError: Error {
    case emptyAddressText
    case emptyRadiusText
    case outOfBounds(Int)

    var localizedDescription: String {
        switch self {
        case .emptyAddressText:
            return "Please Enter An Address"
        case .emptyRadiusText:
            return "Please Enter A Radius"
        case .outOfBounds(let max):
            return "Please Type In A Radius Less Than \(max)"
        }
    }
}

enum MapValidation: String, Error {
    case invalidAddress = "Invalid Address Please Try Again"
    case outsideZone = "Please Enter An NYC Address"
}

enum GeocodingError: String, Error {
    case geocodingFailed = "Invalid Address Please Try Again"
    case invalidCoordinates = "Please Enter An NYC Address"
}
