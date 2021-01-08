//
//  RSSManager.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

enum RSSSource: String, CaseIterable {
    case google
    case gazeta
    case lenta
    
    var url: URL? {
        switch self {
        case .gazeta:
            return URL(string: "http://www.gazeta.ru/export/rss/lenta.xml")
        case .google:
            return URL(string: "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss")
        case .lenta:
            return URL(string: "http://lenta.ru/rss")
        }
    }
}

protocol IRSSManager: class {
    func getNews(sources: [RSSSource], completion: @escaping ([RSSNewsResponse]) -> Void)
}

final class RSSManager: NSObject, IRSSManager {
    
    private var loadedNews = [RSSNewsResponse]()
    
    func getNews(sources: [RSSSource], completion: @escaping ([RSSNewsResponse]) -> Void) {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.EgorOprea.News", attributes: .concurrent)
        
        sources.forEach { source in
            let rssParser = RSSParser()
            group.enter()
            queue.async { [weak self] in
                self?.loadRSS(parser: rssParser, source: source) { news in
                    let news = news.map {
                        RSSNewsResponse(sourceName: source.rawValue,
                                    title: $0.title,
                                    pubDate: $0.pubDate,
                                    description: $0.description,
                                    link: $0.link)
                    }
                    self?.loadedNews += news
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            completion(self.loadedNews)
            self.loadedNews.removeAll()
        }
        
    }
    
    // MARK: - Helpful
    
    private func loadRSS(parser: RSSParser, source: RSSSource, completion: @escaping ([RSSNewsResponse]) -> Void) {

        guard let url = source.url else {
            print(#line, "Bad url")
            return
        }
        
        parser.startParsingWithContentsOfURL(rssURL: url) { parsedData in
            
            let dataArray = parsedData.compactMap { try? JSONEncoder().encode($0) }
            let rssNews = dataArray.compactMap { try? JSONDecoder().decode(RSSNewsResponse.self, from: $0) }

            print("rssNews.count: \(rssNews.count)")
            print(Thread.isMainThread)
            completion(rssNews)
        }
    }
}

