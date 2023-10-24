//
//  HomeViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation

protocol HomeViewModeling {
    var delegate: HomeViewModelDelegate? { get set }
    func fetchData()
    func getSchoolsData() -> [SchoolData]
}

//classes only AnyObject for weak refrences
protocol HomeViewModelDelegate: AnyObject {
    func didUpdate()
}

final class HomeViewModel: HomeViewModeling {
    
    weak var delegate: HomeViewModelDelegate?
    private let dataManager: HomeDataManaging
    private var schools = [School]()
    private var satData = [SATData]()
    private var schoolsData = [SchoolData]()
    
    required init(dataManager: HomeDataManaging) {
        self.dataManager = dataManager
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        dispatchGroup.enter()

        fetchSchools { dispatchGroup.leave() }
        fetchSATData { dispatchGroup.leave() }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self, let delegate = self.delegate else { return }
            
            self.createSchoolData()
            delegate.didUpdate()
        }
    }

    // MARK: - API Calls
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
            
            self.schoolsDataModifier()
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
            
            self.satDataModifier()
            completion()
        }
    }
        
    // MARK: - Create A Merged Text For Search Functionalities, Coordinates Check
    private func schoolsDataModifier() {
        schools = schools.map { school in
            var modifiedSchool = school

            if let index = modifiedSchool.location.firstIndex(of: "(") {
                modifiedSchool.location = String(modifiedSchool.location[..<index])
            }

            var mergedText = modifiedSchool.school_name + modifiedSchool.location
            let charactersToRemove = Set(" ,.-():/")
            mergedText = mergedText.filter { !charactersToRemove.contains($0) }
            mergedText = mergedText.replacingOccurrences(of: "&", with: "and")
            modifiedSchool.mergedText = mergedText

            if modifiedSchool.latitude == nil || modifiedSchool.longitude == nil {
                modifiedSchool.latitude = "0"
                modifiedSchool.longitude = "0"
            }

            return modifiedSchool
        }
    }

    // MARK: - Filter Out Incomplete Scores
    private func satDataModifier() {
        satData = satData.filter { satRecord in
            return Int(satRecord.sat_critical_reading_avg_score) != nil &&
                   Int(satRecord.sat_math_avg_score) != nil &&
                   Int(satRecord.sat_writing_avg_score) != nil
        }
    }
    
    // MARK: - Create Combined Data Model
    private func createSchoolData() {
        for school in schools {
            let satData = satData.first { $0.dbn == school.dbn } ?? SATData(dbn: school.dbn)
            let schoolData = SchoolData(school: school, sat: satData)
            
            schoolsData.append(schoolData)
        }
    }
    
    func getSchoolsData() -> [SchoolData] {
        return schoolsData
    }
}
