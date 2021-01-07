//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
}

extension NewsCollectionViewCell: ConfigurableView {
    func configure(with model: NewsItem) {
        titleLabel?.text = model.title
        dateLabel?.text = model.date
        sourceLabel?.text = model.source?.uppercased()
        if let data = model.imageData {
            imageView?.image = UIImage(data: data)
        } else {
            imageView?.image = UIImage(named: "placeholder")
            imageView?.contentMode = .scaleAspectFit
        }
    }

}

