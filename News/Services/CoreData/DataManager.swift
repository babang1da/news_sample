//
//  DataManager.swift
//  News
//
//  Created by Egor Oprea on 07.01.2021.
//

import Foundation
import CoreData

protocol IDataManager {
    var mainContext: NSManagedObjectContext {get}
    func saveContext()
    var persistentContainer: NSPersistentContainer {get}
}

final class DataManager: IDataManager {
    private init(){}
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
