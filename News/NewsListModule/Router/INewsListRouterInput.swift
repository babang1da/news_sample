//
//  INewsListRouterInput.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

protocol INewsListRouterInput {
    func showSettings()
    func showNewsDetails(for item: NewsItem?)
}
