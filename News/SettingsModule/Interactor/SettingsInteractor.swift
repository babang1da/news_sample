//
//  SettingsInteractor.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

final class SettingsInteractor {
    private var appSettings: IAppSettings
    
    init(appSettings: IAppSettings) {
        self.appSettings = appSettings
    }
}

extension SettingsInteractor: ISettingsInteractorInput {
    var rssSubscriptions: [RSSSource] {
        get {
            appSettings.rssSubscriptions
        }
        set {
            appSettings.rssSubscriptions = newValue
        }
    }
    
    var refreshInterval: TimeInterval {
        get {
            appSettings.refreshInterval
        }
        set {
            appSettings.refreshInterval = newValue
        }
    }
}
