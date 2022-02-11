//
//  TitleTableViewCell.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 40        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: ManufacturerModel) {
        titleLabel.text = model.name
    }
    
    func setSelectedBackgroundColor() {
        containerView.backgroundColor = .red
    }
    
    func setDefaultColor() {
        containerView.backgroundColor = .blue
    }
    
}
