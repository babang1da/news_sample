//
//  Utils.swift
//  NewsAggregator
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

extension String {
    func deleteHTML() -> String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
