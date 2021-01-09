//
//  NewsListRouter.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

final class NewsListRouter {
    
    weak var view: NewsListViewController?
    var output: INewsListRouterOutput?
    
}

extension NewsListRouter: INewsListRouterInput {
    
    func showNewsDetails(for item: NewsItem?) {
        if let destination = view?.storyboard?
            .instantiateViewController(identifier: String(describing: NewsDetailViewController.self)) as? NewsDetailViewController {
            
            destination.newsItem = item
            view?.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func showSettings() {
        if let destination = view?.storyboard?
            .instantiateViewController(identifier: String(describing: SettingsViewController.self)) as? SettingsViewController {
            
            destination.updateNewsList = { [weak self] in
                self?.output?.updateNewsList()
            }
            destination.updateTimer = { [weak self] in
                self?.output?.updateRefreshTimer()
            }
            
            view?.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}
