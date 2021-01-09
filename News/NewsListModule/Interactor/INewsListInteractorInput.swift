//
//  INewsListInteractorInput.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

protocol INewsListInteractorInput: class {
    func updateNewsList()
    func reloadNewsList()
    func updateRefreshTimer()
}
