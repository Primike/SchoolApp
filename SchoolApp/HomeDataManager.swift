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
}

class HomeDataManager: HomeDataManaging {
    private func fetchData<T: Decodable>(url: URL?, customError: CustomError, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = url else {
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

    func getSchools(url: URL?, completion: @escaping (Result<[School], Error>) -> Void) {
        fetchData(url: url, customError: .noSchoolsData, completion: completion)
    }

    func getSATData(url: URL?, completion: @escaping (Result<[SATData], Error>) -> Void) {
        fetchData(url: url, customError: .noSATData, completion: completion)
    }
}
