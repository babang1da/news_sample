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
    func getRSS(sources: [RSSSource], completion: @escaping ([RSSResponse]) -> Void)
}

final class RSSManager: NSObject, IRSSManager {
    
    private let rssParser: IRSSParser
    private var loadedRSS = [RSSResponse]()
    
    init(rssParser: IRSSParser) {
        self.rssParser = rssParser
    }
    
    func getRSS(sources: [RSSSource], completion: @escaping ([RSSResponse]) -> Void) {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.EgorOprea.News", attributes: .concurrent)
        
        sources.forEach { source in
            group.enter()
            queue.async { [weak self] in
                guard let self = self else {return}
                self.loadRSS(parser: self.rssParser, source: source) { news in
                    let news = news.map {
                        RSSResponse(sourceName: source.rawValue,
                                    title: $0.title,
                                    pubDate: $0.pubDate,
                                    description: $0.description,
                                    link: $0.link,
                                    url: $0.url)
                    }
                    self.loadedRSS += news
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            completion(self.loadedRSS)
            self.loadedRSS.removeAll()
        }
        
    }
    
    // MARK: - Helpful
    
    private func loadRSS(parser: IRSSParser, source: RSSSource, completion: @escaping ([RSSResponse]) -> Void) {

        guard let url = source.url else {
            print(#line, "Bad url")
            return
        }
        
        parser.startParsingWithContentsOfURL(rssURL: url) { parsedData in
                        
//            print(parsedData)
            
            let dataArray = parsedData.compactMap { try? JSONEncoder().encode($0) }
            let rssNews = dataArray.compactMap { try? JSONDecoder().decode(RSSResponse.self, from: $0) }

//            print("rssNews: \(rssNews)")
            completion(rssNews)
        }
    }
}

