//
//  ConfigurableView.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import Foundation

protocol ConfigurableView {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
