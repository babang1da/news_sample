//
//  NewsCellModel.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import UIKit

struct NewsItem {
    var source: String?
    var title: String?
    var date: String?
    var description: String?
    var imageURL: String?
    var isFresh: Bool
    
    init(source: String?,
         title: String?,
         date: String?,
         description: String?,
         imageURL: String?,
         isFresh: Bool) {
        
        self.source = source
        self.title = title
        self.date = date
        self.description = description
        self.imageURL = imageURL
        self.isFresh = true
    }
    
    init(dbNewsItem: DBNewsItem) {
        source = dbNewsItem.source
        title = dbNewsItem.title
        date = dbNewsItem.date
        description = dbNewsItem.newsDescription
        imageURL = dbNewsItem.imageURL
        isFresh = true
    }
}

extension NewsItem: Equatable {}
