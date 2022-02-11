//
//  AppCoordinator.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var manufacturerCoordinator: ManufacturerCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startManifacturerCoordinator()
    }
    
    
}

private extension AppCoordinator {
    func startManifacturerCoordinator() {
        manufacturerCoordinator = ManufacturerCoordinator(navigationController: navigationController)
        manufacturerCoordinator?.start()
    }
}
