//
//  Top10SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

protocol TopSchoolsViewModeling {
    var schools: [School] { get set }
    var schoolsScores: [SATData] { get set }
    var topSchools: [School] { get set }
    
    func getTopSchools(selectedSegment: Int, number: Int)
    func getSchool(index: IndexPath) -> School?
    func getSATScores(index: IndexPath) -> SATData
}

class TopSchoolsViewModel: TopSchoolsViewModeling, SchoolCellMethods {
    
    var schools = [School]()
    var schoolsScores = [SATData]()
    var topSchools = [School]()
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
    }
    
    enum TopSchoolsCategory {
        case math
        case reading
        case writing
        case combined
    }
    
    func getTopSchools(selectedSegment: Int, number: Int) {
        var category: TopSchoolsCategory

        switch selectedSegment {
        case 0:
            category = .combined
        case 1:
            category = .math
        case 2:
            category = .reading
        default:
            category = .writing
        }

        sortSATData(category: category)
        addSchools(number: number)
    }
    
    private func sortSATData(category: TopSchoolsCategory) {
        schoolsScores = schoolsScores.sorted(by: { score1, score2 in
            switch category {
            case .math:
                return Int(score1.sat_math_avg_score)! > Int(score2.sat_math_avg_score)!
            case .reading:
                return Int(score1.sat_critical_reading_avg_score)! > Int(score2.sat_critical_reading_avg_score)!
            case .writing:
                return Int(score1.sat_writing_avg_score)! > Int(score2.sat_writing_avg_score)!
            case .combined:
                let totalScore1 = Int(score1.sat_critical_reading_avg_score)! + Int(score1.sat_math_avg_score)! + Int(score1.sat_writing_avg_score)!
                let totalScore2 = Int(score2.sat_critical_reading_avg_score)! + Int(score2.sat_math_avg_score)! + Int(score2.sat_writing_avg_score)!
                return totalScore1 > totalScore2
            }
        })
    }
    
    private func addSchools(number: Int) {
        let topSAT = Array(schoolsScores.prefix(number))
        topSchools = []

        topSAT.forEach { satData in
            if let school = schools.first(where: { $0.dbn == satData.dbn }) {
                topSchools.append(school)
            }
        }
    }

    func getSchool(index: IndexPath) -> School? {
        return topSchools[index.row]
    }
    
    func getSATScores(index: IndexPath) -> SATData {
        return schoolsScores.first(where: {$0.dbn == topSchools[index.row].dbn}) ?? SATData()
    }

    //MARK: Cell Methods
    func getSchoolName(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].boro
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: topSchools[indexPath.row].boro)
    }
}
