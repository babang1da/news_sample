//
//  MockNewsService.swift
//  NewsTests
//
//  Created by Egor Oprea on 09.01.2021.
//

@testable import News
import Foundation

final class MockNewsService: INewsService {
    
    var getNewsCalledCount = 0
    var updateNewsCalledCount = 0
    var eraseCacheCalledCount = 0
    let newsItem = NewsItem(source: "Source",
                            title: "Title",
                            date: nil,
                            description: "Description",
                            imageURL: nil,
                            isFresh: true)
        
    func getNews() -> [NewsItem]? {
        getNewsCalledCount += 1
        return [newsItem]
    }
    
    func updateNews(sources: [RSSSource], completion: @escaping ([NewsItem]?) -> Void) {
        updateNewsCalledCount += 1
        completion([newsItem])
    }
    
    func eraseCache() {
        eraseCacheCalledCount += 1
    }
}
