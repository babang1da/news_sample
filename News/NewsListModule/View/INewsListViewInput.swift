//
//  INewsListViewInput.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

protocol INewsListViewInput: class {
    func cachedNews(_ news: [NewsItem])
    func freshNews(_ news: [NewsItem])
}
