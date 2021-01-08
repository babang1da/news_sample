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
            tableView.tableFooterView = UIView()
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
    private var isTimerChanged = false
    
    // MARK: - Public
    
    var appSettings: IAppSettings? = AppSettings()
    var updateNewsList: (() -> Void)?
    var updateTimer: (() -> Void)?
    
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
        if isTimerChanged {
            updateTimer?()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sources.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as? SettingsTableViewCell {
                
                cell.configure(with: sources[indexPath.row])
                cell.checkBoxButton?.tag = indexPath.row
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimerTableViewCell.self)) as? TimerTableViewCell {
                cell.timeintervalChoosen = { [weak self] timeinterval in
                    self?.appSettings?.refreshInterval = timeinterval
                    self?.isTimerChanged = true
                }
                cell.currentInterval = appSettings?.refreshInterval
                return cell
            }
            
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Sources"
        case 1:
            return "Refresh timer"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 170
        default:
            return 44
        }
    }
    
}
