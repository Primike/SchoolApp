//
//  HomeButtonTag.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/14/23.
//

import Foundation

enum ViewControllerType {
    case schoolsList
    case mapSearch
    case mySchools
    case topSchools
    case satSearch
}

enum HomeButtonTag: Int {
    case schoolsList = 0
    case mapSearch = 1
    case mySchools = 2
    case topSchools = 3
    case satSearch = 4
}

enum HomeImageName: String {
    case schoolWallpaper = "schoolwallpaper"
    case pavement = "pavement"
}
