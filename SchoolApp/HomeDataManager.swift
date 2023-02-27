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
    func getSchools(url: URL?, completion: @escaping (Result<[School], Error>) -> Void) {
        guard let url = url else {
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(CustomError.noSchoolsData))
                return
            }
            
            do {
                var results = try JSONDecoder().decode([School].self, from: data)
                
                completion(.success(results))
            } catch {
                completion(.failure(CustomError.noSchoolsData))
            }
        }
        task.resume()
    }
    
    func getSATData(url: URL?, completion: @escaping (Result<[SATData], Error>) -> Void) {
        guard let url = url else {
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(CustomError.noSATData))
                return
            }
            
            do {
                var results = try JSONDecoder().decode([SATData].self, from: data)
                
                completion(.success(results))
            } catch {
                completion(.failure(CustomError.noSATData))
            }
        }
        task.resume()
    }
}
