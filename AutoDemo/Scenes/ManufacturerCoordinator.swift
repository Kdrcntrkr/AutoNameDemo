//
//  ManifacturerCoordinator.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

class ManufacturerCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startManifacturerFlow()
    }
}

private extension ManufacturerCoordinator {
    func startManifacturerFlow() {
        let businessController = ManufacturerBusinessController(networkManager: NetworkManager())
        let viewController = ManufacturerViewController(businessController: businessController, dataSource: ManufacturerDataSource())
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ManufacturerCoordinator: ManufacturerViewControllerDelegate {
    func manufacturerViewControllerDidTapManufacturer(_ manufacturerViewController: ManufacturerViewController, with manufacturer: ManufacturerModel) {
        let businessController = CarsBusinessController(networkManager: NetworkManager())
        let dataSource = CarsDataSource()
        let viewController = CarsViewController(businessController: businessController, dataSource: dataSource, manufacturer: manufacturer)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ManufacturerCoordinator: CarsViewControllerDelegate {
    func carsViewControllerDidTapCarType(_ carsViewController: CarsViewController, with carInfo: CarInfoModel) {
        let alert = UIAlertController(title: carInfo.manufacturer, message: carInfo.carType, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.navigationController.present(alert, animated: true, completion: nil)
        
    }
}
