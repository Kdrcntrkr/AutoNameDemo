//
//  CarsViewController.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 20.09.2021.
//

import UIKit

protocol CarsViewControllerDelegate: AnyObject {
    func carsViewControllerDidTapCarType(_ carsViewController: CarsViewController, with carInfo: CarInfoModel)
}

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let businessController: CarsBusinessController
    private var dataSource: CarsDataSource
    private let manufacturer: ManufacturerModel
    weak var delegate: CarsViewControllerDelegate?
    
    init(businessController: CarsBusinessController, dataSource: CarsDataSource, manufacturer: ManufacturerModel) {
        self.businessController = businessController
        self.dataSource = dataSource
        self.manufacturer = manufacturer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = manufacturer.name
        configureTableView()
        fetchCarTypes()
    }
    
}

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carType = dataSource.carTypes[indexPath.row]
        let carInfo = CarInfoModel(manufacturer: manufacturer.name, carType: carType.carType)
        delegate?.carsViewControllerDidTapCarType(self, with: carInfo)
    }
}

private extension CarsViewController {
    func configureTableView() {
        dataSource.registerCells(to: tableView)
        tableView.dataSource = dataSource
    }
    
    func fetchCarTypes() {
        businessController.fetchCarTypes(with: manufacturer.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let models):
                self.dataSource.carTypes.append(contentsOf: models)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
