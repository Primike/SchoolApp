//
//  File.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/12/22.
//

import Foundation
import UIKit
//func getSchoolData() {
//    
//    let task = URLSession.shared.dataTask(with: URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!) { data, response, error in
//        
//        defer{
//            self.group.leave()
//        }
//        
//        if let data = data {
//            if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                as? [[String: Any]]) != nil {
//                do {
//                    self.schoolData = try JSONDecoder().decode([School].self, from: data)
//                } catch {
//                    print("ERROR")
//                }
//            }
//        }
//    }
//    task.resume()
//}
//
//func getTestData(){
//    
//    let task = URLSession.shared.dataTask(with: URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!) { data, response, error in
//        defer{
//            self.group.leave()
//        }
//        if let data = data {
//            if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                as? [[String: Any]]) != nil {
//                do {
//                    self.schoolsSATData = try JSONDecoder().decode([SchoolScore].self, from: data)
//                } catch {
//                    print("ERROR")
//                }
//            }
//        }
//    }
//    task.resume()
//}
//
//func handleDispatchleave(){
//    group.notify(queue: .main, execute: {
//        print("notify")
//        self.completedAPICount += 1
//        if self.completedAPICount == 2 {
//            self.view.backgroundColor = .systemBackground
//            self.style()
//            self.layout()
//            self.setup()
//        }
//    })
//}




//    func callSchoolsAPI(){
//        //1. create URL
//
//        if let url = URL(string: urls[0]){
//            //2. Create a Session
//            let session = URLSession(configuration: .default)
//
//            //3. Give Session a Task
//            let task = session.dataTask(with: url) {
//                (data, response, error) in
//                if error != nil{
//                    return
//                }
//                if let data = data {
//                    if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        as? [[String: Any]]) != nil {
//                        self.schoolData = try! JSONDecoder().decode([School].self, from: data)
//                        print(self.schoolData[0])
//                    }
//                }
//
//            }
//            //4. Start Task
//            task.resume()
//        }
//
//    }
//
//    func callSchoolDetailAPI(){
//        //1. create URL
//        if let url = URL(string: urls[1]){
//            //2. Create a Session
//            let session = URLSession(configuration: .default)
//
//            //3. Give Session a Task
//            let task = session.dataTask(with: url) {
//                (data, response, error) in
//                if error != nil{
//                    return
//                }
//                if let data = data {
//                    if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        as? [[String: Any]]) != nil {
//                        self.testData = try! JSONDecoder().decode([SchoolScore].self, from: data)
//                        print(self.testData[0])
//                    }
//                }
//            }
//            //4. Start Task
//            task.resume()
//        }
//
//    }



//    func getData() {
//        group.enter()
//        callSchoolsAPI()
//        group.enter()
//        callSchoolDetailAPI()
//
//        group.notify(queue: .main) { [self] in
//            self.schoolData = schoolServiceApi.schoolData
//            self.testData = schoolServiceApi.schoolsSATData
//            self.style()
//            self.layout()
//            self.setup()
//        }
//    }
