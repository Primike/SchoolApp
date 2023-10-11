//
//  IndividualVCGenerator.swift
//  SchoolApp
//
//  Created by iMac on 10/11/23.
//

import Foundation
import UIKit

enum IndividualVCType: CaseIterable {
    case schoolInfo
    case schoolScores
    case schoolMap
}

protocol Coordinated {
    var coordinator: Coordinating? { get set }
}
 
class IndividualVCGenerator {
    
    static func generateVC(type: IndividualVCType, viewModel: SchoolViewModel) -> Coordinated {
        switch type {
        case .schoolInfo:
            return SchoolInfoViewController(viewModel: viewModel)
        case .schoolScores:
            return SchoolScoresViewController(viewModel: viewModel)
        case .schoolMap:
            return SchoolMapViewController(viewModel: viewModel)
        }
    }
    
    static func getTitle(type: IndividualVCType) -> String {
        switch type {
        case .schoolInfo:
            return "Summary"
        case .schoolScores:
            return "SAT Scores"
        case .schoolMap:
            return "School Map"
        }
    }
    
    static func getImage(type: IndividualVCType) -> String {
        switch type {
        case .schoolInfo:
            return "graduationcap"
        case .schoolScores:
            return "percent"
        case .schoolMap:
            return "mappin"
        }
    }
    
    static func getDeinit(type: IndividualVCType) -> String {
        switch type {
        case .schoolInfo:
            return "Summary Deinit"
        case .schoolScores:
            return "SAT Scores Deinit"
        case .schoolMap:
            return "School Map Deinit"
        }
    }
}
