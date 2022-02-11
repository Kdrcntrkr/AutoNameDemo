//
//  Coordinator.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
