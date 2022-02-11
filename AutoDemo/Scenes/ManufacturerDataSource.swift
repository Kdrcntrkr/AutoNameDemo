//
//  ManufacturerDataSource.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import Foundation
import UIKit

class ManufacturerDataSource: NSObject, UITableViewDataSource {
    
    var manufacturers: [ManufacturerModel] = []
    var selectedCells: [String] = []
    func registerCells(to tableView: UITableView) {
        let nib = UINib(nibName: "TitleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TitleTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        if selectedCells.contains(manufacturers[indexPath.row].id) { cell.setSelectedBackgroundColor() } else { cell.setDefaultColor() }
        cell.config(with: manufacturers[indexPath.row])
        return cell
    }
}
