//
//  SettingsAssembly.swift
//  News
//
//  Created by Egor Oprea on 09.01.2021.
//

import UIKit

final class SettingsAssembly: NSObject {
    
    @IBOutlet weak private var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        // MARK: - Modules
        
        guard let view = viewController as? SettingsViewController else { return }
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(appSettings: AppSettings())
        let router = SettingsRouter()
        
        // MARK: - Presenter injection
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        // MARK: - Router injection
        
        router.view = view
        
        // MARK: - View injection
        
        view.output = presenter
    }
    
}
