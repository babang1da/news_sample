//
//  NewsListCollectionViewDataSource.swift
//  News
//
//  Created by Egor Oprea on 08.01.2021.
//

import UIKit

protocol INewsListCollectionViewDataSource: class, UICollectionViewDataSource {
    var news: [NewsItem] {get set}
}

final class NewsListCollectionViewDataSource: NSObject, INewsListCollectionViewDataSource {
    
    // MARK: - Private
    
    private let cellIdentifier: String
    
    // MARK: - Init
    
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
    
    // MARK: - Public
    
    var news = [NewsItem]()
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsListCollectionViewCell {
            cell.configure(with: news[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
}

