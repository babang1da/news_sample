//
//  NewsDetailViewController.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import UIKit

class NewsDetailViewController: UITableViewController {
    
    // MARK: - UI
    
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Public
    
    var newsItem: NewsItem?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        configureUI(with: newsItem)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Helpful
    
    private func configureUI(with item: NewsItem?) {
        sourceLabel?.text = item?.source?.capitalized
        dateLabel?.text = item?.date?.formatDate
        titleLabel?.text = item?.title
        if let data = item?.imageData {
            imageView?.image = UIImage(data: data)
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
        descriptionLabel?.text = item?.description
    }
    
    // MARK: - TableView Datasource
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
