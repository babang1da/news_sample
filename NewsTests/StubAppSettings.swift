//
//  StubAppSettings.swift
//  NewsTests
//
//  Created by Egor Oprea on 09.01.2021.
//

@testable import News
import Foundation

final class StubAppSettings: IAppSettings {
    var rssSubscriptions: [RSSSource] = []
    var refreshInterval: TimeInterval = 0
}
