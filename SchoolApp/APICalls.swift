//
//  APICalls.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

//alert on api failure retry
//apicall
//viewwilltransitionto

import Foundation

struct SchoolServiceURLs {
    static let schoolDataUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let scoresDataUrl = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
}

enum APIError: Error {
    case failedTogetData
}

enum CustomError {
    case noConnection, noData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No Connection"
        case .noData:
            return "No Data"
        }
    }
}


class SchoolServiceAPI {
    static let shared = SchoolServiceAPI()
    
    func getSchoolsData(completion: @escaping (Result<[School], Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: "\(SchoolServiceURLs.schoolDataUrl)") else {
                  completion(.failure(CustomError.noConnection))
                  return
              }
//        guard let url = URL(string: "\(SchoolServiceURLs.schoolDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                var results = try JSONDecoder().decode([School].self, from: data)
                for i in 0..<results.count {
                    if let index = results[i].location.firstIndex(of: "(") {
                        results[i].location = String(results[i].location[..<index])
                    } else {
                        continue
                    }

                }
                for i in 0..<results.count {
                    var x = results[i].school_name + " " + results[i].location
                    let array = [" ", ",", ".", "-", "(", ")", ":", "/"]
                    for i in array {
                        x = x.replacingOccurrences(of: i, with: "")
                    }
                    x = x.replacingOccurrences(of: "&", with: "and")
                    results[i].mergedText = x
                    
                }
                print(results[0].mergedText!)

                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    

    func getTestData(completion: @escaping (Result<[SchoolScores], Error>) -> Void) {
        
        guard let url = URL(string: "\(SchoolServiceURLs.scoresDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode([SchoolScores].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}



import SystemConfiguration

class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
}
