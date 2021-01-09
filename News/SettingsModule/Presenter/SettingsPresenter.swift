//
//  SettingsPresenter.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

final class SettingsPresenter {
    weak var view: ISettingsViewInput?
    var router: ISettingsRouterInput?
    var interactor: ISettingsInteractorInput?
}

extension SettingsPresenter: ISettingsViewOutput {
    
    var rssSubscriptions: [RSSSource] {
        get {
            interactor?.rssSubscriptions ?? []
        }
        set {
            interactor?.rssSubscriptions = newValue
        }
    }
    
    var refreshInterval: TimeInterval {
        get {
            interactor?.refreshInterval ?? 0
        }
        set {
            interactor?.refreshInterval = newValue
        }
    }

}
