//
//  ManufacturerViewController.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

protocol ManufacturerViewControllerDelegate: AnyObject {
    func manufacturerViewControllerDidTapManufacturer(_ manufacturerViewController: ManufacturerViewController, with manufacturer: ManufacturerModel)
}

class ManufacturerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let businessController: ManufacturerBusinessController
    var dataSource: ManufacturerDataSource
    var isLoadingList : Bool = false
    weak var delegate: ManufacturerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Manufacturers"
        configureTableView()
        businessController.fetchManufacturers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let models):
                self.dataSource.manufacturers.append(contentsOf: models)
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }

    init(businessController: ManufacturerBusinessController, dataSource: ManufacturerDataSource) {
        self.businessController = businessController
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ManufacturerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList && dataSource.manufacturers.count != 0){
                self.isLoadingList = true
                businessController.fetchManufacturers { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let models):
                        self.dataSource.manufacturers.append(contentsOf: models)
                        self.insertRowsToTableView(with: models.count)
                    case .failure(let error):
                        print(error)
                    }
                    self.isLoadingList = false
                }
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource.manufacturers[indexPath.row]
        dataSource.selectedCells.append(model.id)
        delegate?.manufacturerViewControllerDidTapManufacturer(self, with: model)
        guard let cell = tableView.cellForRow(at: indexPath) as? TitleTableViewCell else { return }
        cell.setSelectedBackgroundColor()
        
    }
}

private extension ManufacturerViewController {
    func configureTableView() {
        dataSource.registerCells(to: tableView)
        tableView.dataSource = dataSource
    }
    
    func insertRowsToTableView(with countOfData: Int) {
        let indexPaths = (dataSource.manufacturers.count - countOfData ..< dataSource.manufacturers.count)
            .map { IndexPath(row: $0, section: 0) }
        DispatchQueue.main.async {
            self.tableView.insertRows(at:indexPaths, with: .none)
        }
    }
}

