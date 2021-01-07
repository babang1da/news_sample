//
//  AppSettings.swift
//  News
//
//  Created by Egor Oprea on 07.01.2021.
//

import Foundation

protocol IAppSettings {
    var rssSubscriptions: [RSSSource] {get set}
}

final class AppSettings: IAppSettings {
    
    private enum DefaultsKeys: String {
        case rssSubscriptions
    }
    
    private let defaults = UserDefaults.standard
    
    var rssSubscriptions: [RSSSource] {
        get {
            guard let rawValues = defaults.stringArray(forKey: DefaultsKeys.rssSubscriptions.rawValue) else {
                return []
            }
            return rawValues.compactMap { RSSSource(rawValue: $0) }
        }
        set {
            let rawValues = newValue.map { $0.rawValue }
            defaults.set(rawValues, forKey: DefaultsKeys.rssSubscriptions.rawValue)
        }
    }
}
