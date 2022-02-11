//
//  CarsDataSource.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 20.09.2021.
//

import Foundation
import UIKit

class CarsDataSource: NSObject, UITableViewDataSource {
    
    var carTypes: [CarTypeModel] = []
        
    func registerCells(to tableView: UITableView) {
        let nib = UINib(nibName: "CarTypeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CarTypeTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTypeTableViewCell", for: indexPath) as? CarTypeTableViewCell else {
            return UITableViewCell()
        }
        cell.config(with: carTypes[indexPath.row])
        return cell
    }
}
