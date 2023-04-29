//
//  HomeDataManager.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation

protocol HomeDataManaging {
    func getSchools(url: URL?, completion: @escaping (Result<[School], Error>) -> Void)
    func getSATData(url: URL?, completion: @escaping (Result<[SATData], Error>) -> Void)
    func getLocalSchools(fileName: String) -> [School]
    func getLocalSATData(fileName: String) -> [SATData]
}

class HomeDataManager: HomeDataManaging {
    private func fetchData<T: Decodable>(url: URL?, customError: CustomError, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = url else {
            completion(.failure(customError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(customError))
                return
            }
            
            do {
                let results = try JSONDecoder().decode([T].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(customError))
            }
        }
        task.resume()
    }

    func getLocalData<T: Decodable>(fileName: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Unable to locate file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON data: \(error)")
            return nil
        }
    }

    func getSchools(url: URL?, completion: @escaping (Result<[School], Error>) -> Void) {
        fetchData(url: url, customError: .noSchoolsData, completion: completion)
    }

    func getSATData(url: URL?, completion: @escaping (Result<[SATData], Error>) -> Void) {
        fetchData(url: url, customError: .noSATData, completion: completion)
    }
    
    func getLocalSchools(fileName: String) -> [School] {
        return getLocalData(fileName: fileName, type: [School].self) ?? [School]()
    }
        
    func getLocalSATData(fileName: String) -> [SATData] {
        return getLocalData(fileName: fileName, type: [SATData].self) ?? [SATData]()
    }
}
