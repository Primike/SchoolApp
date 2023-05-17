//
//  SchoolCellMethods.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

protocol SchoolCellMethods: SchoolColor {
    func getSchoolName(indexPath: IndexPath) -> String
    func getSchoolAddress(indexPath: IndexPath) -> String
    func getSchoolBoro(indexPath: IndexPath) -> String
    func getSchoolColor(indexPath: IndexPath) -> UIColor
    func getColor(schoolBoro: Borough) -> UIColor
}

protocol SchoolColor {
    func getColor(schoolBoro: Borough) -> UIColor

}

extension SchoolColor {
    func getColor(schoolBoro: Borough) -> UIColor {
        switch schoolBoro {
        case .manhattan:
            return .systemBlue
        case .bronx:
            return .systemOrange
        case .brooklyn:
            return .systemRed
        case .queens:
            return .systemPurple
        case .statenIsland:
            return .systemGreen
        }
    }
}

enum Borough: String, Decodable {
    case manhattan = "M"
    case bronx = "X"
    case brooklyn = "K"
    case queens = "Q"
    case statenIsland = "R"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let boroCode = try container.decode(String.self)
        
        switch boroCode {
        case "M":
            self = .manhattan
        case "X":
            self = .bronx
        case "K":
            self = .brooklyn
        case "Q":
            self = .queens
        case "R":
            self = .statenIsland
        default:
            self = .manhattan
        }
    }
}
