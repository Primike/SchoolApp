//
//  SchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/14/22.
//

import Foundation

//class SchoolsViewModel: NSObject {
//    
//    private var schoolService: SchoolServiceAPI!
//    
//    private(set) var schoolData: Schools! {
//        didSet {
//            self.bindSchoolViewModelToController()
//        }
//    }
//    
//    var bindSchoolViewModelToController: (() -> ()) = {}
//    
//    override init() {
//        super.init()
//        self.schoolService = SchoolServiceAPI()
//        callFuncToGetSchoolData()
//    }
//    
//    func callFuncToGetSchoolData() {
//        self.schoolService.getSchoolData { (schoolData) in
//            self.schoolData = schoolData
//        }
//    }
//}
