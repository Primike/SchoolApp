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
    case about
}

enum HomeButtonTag: Int {
    case schoolsList = 0
    case mapSearch = 1
    case mySchools = 2
    case about = 3
}

enum HomeImageName: String {
    case schoolWallpaper = "schoolwallpaper"
    case pavement = "pavement"
}
