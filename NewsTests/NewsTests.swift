//
//  NewsTests.swift
//  NewsTests
//
//  Created by Egor Oprea on 09.01.2021.
//

@testable import News
import XCTest

class NewsTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testNewsListInteractor() {
        //given
        let appSettings = StubAppSettings()
        let output = MockInteractorOutput()
        let newsService = MockNewsService()
        
        //when
        let sut = NewsListInteractor()
        sut.appSettings = appSettings
        sut.interactorOutput = output
        sut.newsService = newsService
        
        sut.reloadNewsList()
        sut.updateNewsList()
        sut.updateRefreshTimer()
        
        //then
        XCTAssertEqual(output.cachedNewsCalls, 2)
        XCTAssertEqual(output.freshNewsCalls, 2)
        XCTAssertEqual(output.cachedNews, [newsService.newsItem])
        XCTAssertEqual(output.freshNews, [newsService.newsItem])
        
        XCTAssertEqual(newsService.eraseCacheCalledCount, 1)
        XCTAssertEqual(newsService.getNewsCalledCount, 2)
        XCTAssertEqual(newsService.updateNewsCalledCount, 2)
    }


}
