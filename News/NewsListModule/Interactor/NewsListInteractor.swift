//
//  NewsListInteractor.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

final class NewsListInteractor {
    
    weak var interactorOutput: INewsInteractorOutput?
    var appSettings: IAppSettings?
    var newsService: INewsService?
    
    private var timer: Timer?
    
}

// MARK: - INewsListInteractorInput

extension NewsListInteractor: INewsListInteractorInput {
    
    func reloadNewsList() {
        newsService?.eraseCache()
        updateNewsList()
    }
    
    func updateNewsList() {
        if let news = newsService?.getNews() {
            interactorOutput?.cachedNews(news)
        }
        
        if let sources = appSettings?.rssSubscriptions {
            newsService?.updateNews(sources: sources) { [weak self] items in
                if let news = items {
                    self?.interactorOutput?.freshNews(news)
                }
            }
        }
    }
    
    func updateRefreshTimer() {
        timer?.invalidate()
        timer = nil
        
        guard let interval = appSettings?.refreshInterval, interval > 0 else {return}
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] _ in
            self?.updateNewsList()
        })
        
    }
}
