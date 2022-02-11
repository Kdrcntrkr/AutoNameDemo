//
//  CarTypeTableViewCell.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 20.09.2021.
//

import UIKit

class CarTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 40
        containerView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(with model: CarTypeModel) {
        titleLabel.text = model.carType
    }
}
