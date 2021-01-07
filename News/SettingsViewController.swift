//
//  SettingsViewController.swift
//  News
//
//  Created by Egor Oprea on 07.01.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Datasource
    
    private lazy var allRSSSources: [RSSSource.RawValue: Bool] = {
        var dict = [RSSSource.RawValue: Bool]()
        RSSSource.allCases.forEach { dict[$0.rawValue] = false }
        return dict
    }()
    private lazy var rssSubscriptions: [RSSSource] = {
        return appSettings?.rssSubscriptions ?? []
    }()
    private var sources = [RSSSubscription]()
    private var sourcesCopy = [RSSSubscription]()
    
    // MARK: - Public
    
    var appSettings: IAppSettings? = AppSettings()
    var updateNewsList: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        defineSubscriptions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        appSettings?.rssSubscriptions = sources.filter { $0.isActive }.compactMap { RSSSource(rawValue: $0.name) }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if sources != sourcesCopy {
            updateNewsList?()
        }
    }
    
    // MARK: - Helpful
    
    private func defineSubscriptions() {
        rssSubscriptions.forEach { allRSSSources[$0.rawValue] = true }
        sources = allRSSSources.map { RSSSubscription(name: $0.key, isActive: $0.value) }
        sourcesCopy = sources
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction private func actionCheckBox(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sources[sender.tag].isActive = true
        } else {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            sources[sender.tag].isActive = false
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as? SettingsTableViewCell {
            
            cell.configure(with: sources[indexPath.row])
            cell.checkBoxButton?.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    
}
