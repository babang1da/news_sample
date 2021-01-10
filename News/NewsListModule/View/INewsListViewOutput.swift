//
//  INewsListViewOutput.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

protocol INewsListViewOutput: class {
    func updateNewsList()
    func showSettings()
    func showNewsDetails(for item: NewsItem?)
}
