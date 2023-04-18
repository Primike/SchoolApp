//
//  SchoolCellMethods.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

protocol SchoolCellMethods {
    func getSchoolName(indexPath: IndexPath) -> String
    func getSchoolAddress(indexPath: IndexPath) -> String
    func getSchoolBoro(indexPath: IndexPath) -> String
    func getSchoolColor(indexPath: IndexPath) -> UIColor
    func getColor(schoolBoro: String) -> UIColor
}

protocol SchoolColor {
    func getColor(schoolBoro: String) -> UIColor

}

extension SchoolColor {
    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.systemRed
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}

extension SchoolCellMethods {
    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.systemRed
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}
