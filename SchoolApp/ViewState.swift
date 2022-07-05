//
//  ViewState.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/5/22.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}

protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
