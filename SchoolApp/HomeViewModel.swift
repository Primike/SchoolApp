//
//  HomeViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation

class HomeViewModel {

    var dataMangaer: HomeDataManaging
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    
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
    
    func getSchoolScores(completion: @escaping (Result<[SchoolScores], Error>) -> Void) {
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
        var results = results
        
        for i in 0..<results.count {
            if let index = results[i].location.firstIndex(of: "(") {
                results[i].location = String(results[i].location[..<index])
            }
        }
        
        for i in 0..<results.count {
            var mergedText = results[i].school_name + results[i].location
            let array = [" ", ",", ".", "-", "(", ")", ":", "/"]
            for j in array {
                mergedText = mergedText.replacingOccurrences(of: j, with: "")
            }
            mergedText = mergedText.replacingOccurrences(of: "&", with: "and")
            results[i].mergedText = mergedText
        }
        
        for i in 0..<results.count {
            if results[i].latitude == nil || results[i].longitude == nil{
                results[i].latitude = "0"
                results[i].longitude = "0"
            }
        }
        
        return results
    }
    
    func satDataModifier(satData: [SchoolScores]) -> [SchoolScores] {
        var satData = satData
        
        for i in 0..<satData.count {
            if Int(satData[i].sat_critical_reading_avg_score) != nil && Int(satData[i].sat_math_avg_score) != nil && Int(satData[i].sat_writing_avg_score) != nil {
            } else {
                satData[i] = SchoolScores()
            }
        }
        
        return satData
    }
}

