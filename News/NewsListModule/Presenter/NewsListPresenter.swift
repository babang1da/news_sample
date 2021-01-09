//
//  NewsListPresenter.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import Foundation

final class NewsListPresenter {
    
    weak var view: INewsListViewInput?
    var interactor: INewsListInteractorInput?
    var router: INewsListRouterInput?
    
}

// MARK: - INewsListViewOutput

extension NewsListPresenter: INewsListViewOutput {
    
    func showNewsDetails(for item: NewsItem?) {
        router?.showNewsDetails(for: item)
    }
    
    func showSettings() {
        router?.showSettings()
    }
    
    func reloadNewsList() {
        interactor?.reloadNewsList()
    }
    
    
    func updateNewsList() {
        interactor?.updateNewsList()
    }
    
    func updateRefreshTimer() {
        interactor?.updateRefreshTimer()
    }
}

// MARK: - INewsInteractorOutput

extension NewsListPresenter: INewsInteractorOutput {

    func cachedNews(_ news: [NewsItem]) {
        view?.cachedNews(news)
    }
    
    func freshNews(_ news: [NewsItem]) {
        view?.freshNews(news)
    }
    
}

extension NewsListPresenter: INewsListRouterOutput {}
