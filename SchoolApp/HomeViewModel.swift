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
    func schoolsDataModifier(results: [School]) -> [School]
    func satDataModifier(satData: [SATData]) -> [SATData]
}

//classes only Anyobject for weak refrences
protocol HomeViewModelDelegate: AnyObject {
    func didUpdate()
}

class HomeViewModel: HomeViewModeling {
    var dataMangaer: HomeDataManaging
    var schools = [School]()
    var schoolsScores = [SATData]()
    weak var delegate: HomeViewModelDelegate?
    
    required init(dataManager: HomeDataManaging) {
        self.dataMangaer = dataManager
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        dispatchGroup.enter()

        fetchSchools {
            dispatchGroup.leave()
        }

        fetchSATData {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didUpdate()
        }
    }

    func fetchSchools(completion: @escaping () -> Void) {
        dataMangaer.getSchools(url: URLs.schoolsURL.value) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let schools):
                self.schools = schools
            case .failure(_):
                let schools = self.dataMangaer.getLocalSchools(fileName: LocalFiles.localSchoolsURL.rawValue)
                self.schools = schools
            }
            completion()
        }
    }

    func fetchSATData(completion: @escaping () -> Void) {
        dataMangaer.getSATData(url: URLs.schoolsURL.value) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let satData):
                self.schoolsScores = satData
            case .failure(_):
                let satData = self.dataMangaer.getLocalSATData(fileName: LocalFiles.localSATDataURL.rawValue)
                self.schoolsScores = satData
            }
            completion()
        }
    }
    
    //MARK: Modify data to improve search results
    func schoolsDataModifier(results: [School]) -> [School] {
        return results.map { school in
            var updatedSchool = school

            if let index = updatedSchool.location.firstIndex(of: "(") {
                updatedSchool.location = String(updatedSchool.location[..<index])
            }

            let mergedText = updatedSchool.school_name + updatedSchool.location
            let charactersToRemove = Set(" ,.-():/")
            let mergedTextWithoutSpecialChars = mergedText.filter { !charactersToRemove.contains($0) }
            let finalMergedText = mergedTextWithoutSpecialChars.replacingOccurrences(of: "&", with: "and")
            updatedSchool.mergedText = finalMergedText

            if updatedSchool.latitude == nil || updatedSchool.longitude == nil {
                updatedSchool.latitude = "0"
                updatedSchool.longitude = "0"
            }

            return updatedSchool
        }
    }

    //MARK: If an element has incomplete scores replace with SATDATA() for app features
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
