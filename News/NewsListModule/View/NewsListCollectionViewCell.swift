//
//  NewsListCollectionViewCell.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import UIKit

final class NewsListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var isFreshView: UIView! {
        didSet {
            isFreshView.layer.cornerRadius = isFreshView.bounds.width / 2
        }
    }
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = nil
    }
    
    override var isSelected: Bool {
        didSet {
            isFreshView?.isHidden = true
        }
    }

    
}

extension NewsListCollectionViewCell: IConfigurableView {
    func configure(with model: NewsItem) {
        titleLabel?.text = model.title
        dateLabel?.text = model.date?.formatDate
        sourceLabel?.text = model.source?.uppercased()
        isFreshView?.isHidden = !model.isFresh
        
        imageView?.image = UIImage(named: "placeholder")
        
        if let stringURL = model.imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = URL(string: stringURL), let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        self?.spinner.stopAnimating()
                        if url.absoluteString == stringURL {
                            self?.imageView?.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }

}

