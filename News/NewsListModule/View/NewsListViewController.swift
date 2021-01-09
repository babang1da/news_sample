//
//  NewsListViewController.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import UIKit

class NewsListViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = dataSource
            collectionView.collectionViewLayout = flowLayout
        }
    }
    
    // MARK: - Private
    
    private var timer: Timer?

    private lazy var flowLayout: UICollectionViewCompositionalLayout = {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    // MARK: - Injections
    
    var output: INewsListViewOutput?
    
    private lazy var dataSource: INewsListCollectionViewDataSource? = {
        NewsListCollectionViewDataSource(cellIdentifier: String(describing: NewsListCollectionViewCell.self))
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        addLoadDataObserver()
        
        output?.updateNewsList()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    // MARK: - Helpful
    
    private func refreshView(with items: [NewsItem]) {
        dataSource?.news = items
        collectionView.reloadData()
    }
    
    // MARK: - Actions

    @IBAction func actionSettings(_ sender: UIBarButtonItem) {
        output?.showSettings()
    }
}

// MARK: - UICollectionViewDelegate

extension NewsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dataSource?.news[indexPath.item].isFresh = false
        collectionView.reloadItems(at: [indexPath])
        
        output?.showNewsDetails(for: dataSource?.news[indexPath.item])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = width * 2 / 3
        return CGSize(width: width, height: height)
    }
}

// MARK: - INewsListViewInput

extension NewsListViewController: INewsListViewInput {
    
    func cachedNews(_ news: [NewsItem]) {
        refreshView(with: news)
    }
    
    func freshNews(_ news: [NewsItem]) {
        refreshView(with: news)
    }
    
}

