//
//  NewsViewController.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = flowLayout
        }
    }
    
    // MARK: - Private
        
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
    
    private var sources: [RSSSource] {
        appSettings.rssSubscriptions
    }
    
    //test
    private var appSettings: IAppSettings = AppSettings()
    
    private var newsService: INewsService = NewsService(provider: RSSManager(),
                                                        dataManager: DataManager.shared)
    
    // MARK: - Datasource
    
    private var news = [NewsItem]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        addLoadDataObserver()
        getNews()
        updateNews(sources: sources)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        updateNews(sources: sources)
//    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    // MARK: - Helpful
    
    private func getNews() {
        print(#function)
        if let items = newsService.getNews() {
            news = items
            collectionView.reloadData()
        }
    }
    
    private func updateNews(sources: [RSSSource]) {
        newsService.updateNews(sources: sources) { [weak self] items in
            print(#function)
            if let items = items {
                print("items.count: \(items.count)")
                self?.news = items
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func actionReload(_ sender: UIBarButtonItem) {
        updateNews(sources: sources)
    }
    
    @IBAction func actionSettings(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(identifier: String(describing: SettingsViewController.self)) as? SettingsViewController {
            vc.updateNewsList = { [weak self] in
                guard let self = self else {return}
                self.newsService.eraseCache()
                self.getNews()
                self.updateNews(sources: self.sources)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsCollectionViewCell.self), for: indexPath) as? NewsCollectionViewCell {
            cell.configure(with: news[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: String(describing: NewsDetailViewController.self)) as? NewsDetailViewController {
            vc.newsItem = news[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = width * 2 / 3
        return CGSize(width: width, height: height)
    }
}

