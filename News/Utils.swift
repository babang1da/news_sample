//
//  Utils.swift
//  NewsAggregator
//
//  Created by Egor Oprea on 05.01.2021.
//

import UIKit

extension String {
    func deleteHTML() -> String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension String {
    var formatDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let date = dateFormatter.date(from: self) else {return ""}
        return date.formatDate
    }
}

extension Date {
    var formatDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension UIViewController {
    func embededInNAvigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func addLoadDataObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSpinner),
                                               name: .beginLoadData,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideSpinner),
                                               name: .endLoadData,
                                               object: nil)
    }
    
    @objc
    private func showSpinner() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        
        let titleLabel = UILabel()
        titleLabel.text = "Connecting..."
        titleLabel.textColor = .darkGray
        
        let fittingSize = titleLabel.sizeThatFits(CGSize(width: 100, height: activityIndicator.frame.size.height))
        titleLabel.frame = CGRect(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width + 8,
                                  y: activityIndicator.frame.origin.y,
                                  width: fittingSize.width,
                                  height: fittingSize.height)
        
        let rect = CGRect(x: (activityIndicator.frame.size.width + 8 + titleLabel.frame.size.width) / 2,
                          y: (activityIndicator.frame.size.height) / 2,
                          width: activityIndicator.frame.size.width + 8 + titleLabel.frame.size.width,
                          height: activityIndicator.frame.size.height)
        let titleView = UIView(frame: rect)
        titleView.addSubview(activityIndicator)
        titleView.addSubview(titleLabel)
        
        navigationItem.titleView = titleView
    }
    
    @objc
    private func hideSpinner() {
        navigationItem.titleView = nil
    }
}

extension Notification.Name {
    static let beginLoadData = Notification.Name("com.EgorOprea.News.BeginLoadData")
    static let endLoadData = Notification.Name("com.EgorOprea.News.EndLoadData")
}
