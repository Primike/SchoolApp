//
//  RootViewCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/7/22.
//

import Foundation
import UIKit

public protocol RootViewControllerProvider: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
}

public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider
