//
//  DBNewsItem+CoreDataProperties.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//
//

import Foundation
import CoreData


extension DBNewsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBNewsItem> {
        return NSFetchRequest<DBNewsItem>(entityName: "DBNewsItem")
    }

    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var date: String?

}

extension DBNewsItem : Identifiable {

}

extension DBNewsItem {
    convenience init(source: String?,
                     title: String?,
                     description: String?,
                     date: String?,
                     imageData: Data?,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.source = source
        self.title = title
        self.newsDescription = description
        self.imageData = imageData
        self.date = date
    }
}
