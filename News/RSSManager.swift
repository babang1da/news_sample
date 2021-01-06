//
//  RSSManager.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

enum RSSSource: String {
    case google
    case gazeta
    
    var url: URL? {
        switch self {
        case .gazeta:
            return URL(string: "http://www.gazeta.ru/export/rss/lenta.xml")
        case .google:
            return URL(string: "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss")
        }
    }
}

protocol IRSSManager: class {
    
}

final class RSSManager: NSObject, IRSSManager {
    
    private let rssParser = RSSParser()
    private var loadedNews = [RSSNewsItem]()
    
    func getNews(sources: [RSSSource], completion: @escaping ([RSSNewsItem]) -> Void) {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.EgorOprea.News", attributes: .concurrent)
        
        sources.forEach { source in
            group.enter()
            queue.async(flags: .barrier) { [weak self] in
                self?.loadRSS(source: source) { news in
                    let news = news.map {
                        RSSNewsItem(sourceName: source.rawValue,
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
            completion(self.loadedNews.sorted())
        }
        
    }
    
    // MARK: - Helpful
    
    private func loadRSS(source: RSSSource, completion: @escaping ([RSSNewsItem]) -> Void) {

        guard let url = source.url else {
            print(#line, "Bad url")
            return
        }
        print(#function)
        rssParser.startParsingWithContentsOfURL(rssURL: url) { parsedData in
            
            let dataArray = parsedData.compactMap { try? JSONEncoder().encode($0) }
            let rssNews = dataArray.compactMap { try? JSONDecoder().decode(RSSNewsItem.self, from: $0) }
            
            completion(rssNews)
        }
    }
}

