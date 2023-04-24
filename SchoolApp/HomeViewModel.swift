//
//  HomeViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation

protocol HomeViewModeling {
    var dataMangaer: HomeDataManaging { get set }
    var schools: [School] { get set }
    var schoolsScores: [SATData] { get set }
    func getSchools(completion: @escaping (Result<[School], Error>) -> Void)
    func getSchoolScores(completion: @escaping (Result<[SATData], Error>) -> Void)
    func schoolsDataModifier(results: [School]) -> [School]
    func satDataModifier(satData: [SATData]) -> [SATData]
}

class HomeViewModel: HomeViewModeling {
    var dataMangaer: HomeDataManaging
    var schools = [School]()
    var schoolsScores = [SATData]()
    
    required init(dataManager: HomeDataManaging) {
        self.dataMangaer = dataManager
    }
    
    func getSchools(completion: @escaping (Result<[School], Error>) -> Void) {
        dataMangaer.getSchools(url: URLs.schoolsURL.value, completion: {[weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let schools):
                self.schools = schools
                completion(.success(schools))
            case .failure(_):
                self.dataMangaer.getSchools(url: URLs.localSchoolsURL.value) { result in
                    switch result {
                    case .success(let schools):
                        self.schools = schools
                        completion(.success(schools))
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    }
                }
            }
            self.schools = self.schoolsDataModifier(results: self.schools)
        })
    }
    
    func getSchoolScores(completion: @escaping (Result<[SATData], Error>) -> Void) {
        dataMangaer.getSATData(url: URLs.satDataURL.value, completion: {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let scores):
                self.schoolsScores = scores
                completion(.success(scores))
            case .failure(_):
                self.dataMangaer.getSATData(url: URLs.localSATDataURL.value) { result in
                    switch result {
                    case .success(let schools):
                        self.schoolsScores = schools
                        completion(.success(schools))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            self.schoolsScores = self.satDataModifier(satData: self.schoolsScores)
        })
    }
    
    func schoolsDataModifier(results: [School]) -> [School] {
        var modifiedResults = results.map { (school) -> School in
            var updatedSchool = school
            
            if let index = updatedSchool.location.firstIndex(of: "(") {
                updatedSchool.location = String(updatedSchool.location[..<index])
            }
            
            var mergedText = updatedSchool.school_name + updatedSchool.location
            let array = [" ", ",", ".", "-", "(", ")", ":", "/"]
            array.forEach { character in
                mergedText = mergedText.replacingOccurrences(of: character, with: "")
            }
            mergedText = mergedText.replacingOccurrences(of: "&", with: "and")
            updatedSchool.mergedText = mergedText
            
            if updatedSchool.latitude == nil || updatedSchool.longitude == nil {
                updatedSchool.latitude = "0"
                updatedSchool.longitude = "0"
            }
            
            return updatedSchool
        }
        
        return modifiedResults
    }

    func satDataModifier(satData: [SATData]) -> [SATData] {
        let modifiedSatData = satData.map { satRecord -> SATData in
            if Int(satRecord.sat_critical_reading_avg_score) != nil,
               Int(satRecord.sat_math_avg_score) != nil,
               Int(satRecord.sat_writing_avg_score) != nil {
                return satRecord
            } else {
                return SATData()
            }
        }
        
        return modifiedSatData
    }
}
