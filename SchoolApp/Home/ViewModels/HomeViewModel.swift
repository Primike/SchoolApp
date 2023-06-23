//
//  HomeViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation

protocol HomeViewModeling {
    var schools: [School] { get }
    var satData: [SATData] { get }
    var delegate: HomeViewModelDelegate? { get set }
    func fetchData()
}

//classes only Anyobject for weak refrences
protocol HomeViewModelDelegate: AnyObject {
    func didUpdate()
}

final class HomeViewModel: HomeViewModeling {
    
    private let dataManager: HomeDataManaging
    private(set) var schools = [School]()
    private(set) var satData = [SATData]()
    weak var delegate: HomeViewModelDelegate?
    
    required init(dataManager: HomeDataManaging) {
        self.dataManager = dataManager
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
            guard let self = self, let delegate = self.delegate else { return }
            delegate.didUpdate()
        }
    }

    private func fetchSchools(completion: @escaping () -> Void) {
        dataManager.getSchools(url: URLs.schoolsURL.value) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let schools):
                self.schools = schools
            case .failure(let error):
                print("Fetch Schools Failed: \(error.localizedDescription)")
                let schools = self.dataManager.getLocalSchools(fileName: LocalFilesPath.schoolsPath.rawValue)
                self.schools = schools
            }
            
            self.schools = self.schoolsDataModifier(results: self.schools)
            completion()
        }
    }

    private func fetchSATData(completion: @escaping () -> Void) {
        dataManager.getSATData(url: URLs.schoolsURL.value) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let satData):
                self.satData = satData
            case .failure(let error):
                print("Fetch SAT Data Failed: \(error.localizedDescription)")
                let satData = self.dataManager.getLocalSATData(fileName: LocalFilesPath.satDataPath.rawValue)
                self.satData = satData
            }
            
            self.satData = self.satDataModifier(satData: self.satData)
            completion()
        }
    }
    
    //MARK: Modify data to improve search results
    private func schoolsDataModifier(results: [School]) -> [School] {
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
    private func satDataModifier(satData: [SATData]) -> [SATData] {
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
