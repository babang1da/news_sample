//
//  NewsDetailViewController.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
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

        configureUI(with: newsItem)
    }
    
    // MARK: - Helpful
    
    private func configureUI(with model: NewsItem?) {
        sourceLabel?.text = model?.source?.capitalized
        dateLabel?.text = model?.date
        titleLabel?.text = model?.title
        descriptionLabel?.text = model?.description
        if let data = model?.imageData {
            imageView?.image = UIImage(data: data)
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
    }

}
