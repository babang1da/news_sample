//
//  MockInteractorOutput.swift
//  NewsTests
//
//  Created by Egor Oprea on 09.01.2021.
//

@testable import News
import Foundation

final class MockInteractorOutput: INewsInteractorOutput {
    
    var cachedNewsCalls = 0
    var freshNewsCalls = 0
    var cachedNews = [NewsItem]()
    var freshNews = [NewsItem]()
    
    func cachedNews(_ news: [NewsItem]) {
        cachedNewsCalls += 1
        cachedNews = news
    }
    
    func freshNews(_ news: [NewsItem]) {
        freshNewsCalls += 1
        freshNews = news
    }
}
