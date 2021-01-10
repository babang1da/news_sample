//
//  NewsTests.swift
//  NewsTests
//
//  Created by Egor Oprea on 09.01.2021.
//

@testable import News
import XCTest

class NewsTests: XCTestCase {
    
    var appSettings: StubAppSettings!
    var output: MockInteractorOutput!
    var newsService: MockNewsService!

    override func setUp() {
        appSettings = StubAppSettings()
        output = MockInteractorOutput()
        newsService = MockNewsService()
    }

    override func tearDown() {
        
    }
    
    func testNewsListInteractorUpdateNewsList() {

        let sut = NewsListInteractor()
        sut.appSettings = appSettings
        sut.interactorOutput = output
        sut.newsService = newsService
        
        sut.updateNewsList()
        
        XCTAssertEqual(output.cachedNewsCalls, 1)
        XCTAssertEqual(output.freshNewsCalls, 1)
        XCTAssertEqual(output.cachedNews, [newsService.newsItem])
        XCTAssertEqual(output.freshNews, [newsService.newsItem])
        
        XCTAssertEqual(newsService.eraseCacheCalledCount, 0)
        XCTAssertEqual(newsService.getNewsCalledCount, 1)
        XCTAssertEqual(newsService.updateNewsCalledCount, 1)
    }
    
    func testNewsListInteractorReloadNewsList() {
        
        let sut = NewsListInteractor()
        sut.appSettings = appSettings
        sut.interactorOutput = output
        sut.newsService = newsService
        
        sut.reloadNewsList()
        
        XCTAssertEqual(output.cachedNewsCalls, 1)
        XCTAssertEqual(output.freshNewsCalls, 1)
        XCTAssertEqual(output.cachedNews, [newsService.newsItem])
        XCTAssertEqual(output.freshNews, [newsService.newsItem])
        
        XCTAssertEqual(newsService.eraseCacheCalledCount, 1)
        XCTAssertEqual(newsService.getNewsCalledCount, 1)
        XCTAssertEqual(newsService.updateNewsCalledCount, 1)
    }
    
    func testNewsListInteractorUpdateRefreshTimer() {

        let sut = NewsListInteractor()
        sut.appSettings = appSettings
        sut.interactorOutput = output
        sut.newsService = newsService
        
        sut.updateRefreshTimer()
        
        XCTAssertEqual(output.cachedNewsCalls, 0)
        XCTAssertEqual(output.freshNewsCalls, 0)
        
        XCTAssertEqual(newsService.eraseCacheCalledCount, 0)
        XCTAssertEqual(newsService.getNewsCalledCount, 0)
        XCTAssertEqual(newsService.updateNewsCalledCount, 0)
    }

}
