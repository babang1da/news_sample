//
//  SettingsTableViewCell.swift
//  News
//
//  Created by Egor Oprea on 07.01.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, ConfigurableView {

    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    func configure(with model: RSSSubscription) {
        sourceLabel?.text = model.name
        if model.isActive {
            checkBoxButton?.setImage(UIImage(systemName: "checkmark.circle"),
                                     for: .normal)
        } else {
            checkBoxButton?.setImage(UIImage(systemName: "circle"),
                                     for: .normal)
        }
    }
        
}
