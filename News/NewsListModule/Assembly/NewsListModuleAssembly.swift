//
//  NewsListModuleAssembly.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import UIKit

final class NewsListModuleAssembly: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = viewController as? NewsListViewController else { return }
        let presenter = NewsListPresenter()
        let interactor = NewsListInteractor()
        let router = NewsListRouter()
        
        // MARK: - Managers
        
        let dataManager = DataManager.shared
        let parser = RSSParser()
        let provider = RSSManager(rssParser: parser)
        let newsService = NewsService(provider: provider, dataManager: dataManager)
        let appSettings = AppSettings()
        
        // MARK: - Interactor injection
        
        interactor.appSettings = appSettings
        interactor.newsService = newsService
        interactor.interactorOutput = presenter
        
        // MARK: - Presenter injection
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        // MARK: - Router injection
        
        router.view = view
        router.output = presenter
        
        // MARK: - View injection
        
        view.output = presenter
    }
    
}
