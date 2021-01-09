//
//  ISettingsInteractorInput.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

protocol ISettingsInteractorInput: class {
    var rssSubscriptions: [RSSSource] {get set}
    var refreshInterval: TimeInterval {get set}
}
