//
//  TestCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 12/06/2023.
//

import CoreData
import Reciplease

//class TestCoreDataStack: CoreDataStack {
//
//    convenience init() {
//        self.init(modelName: "Reciplease")
//    }
//
//        lazy var persistentContainer: NSPersistentContainer = {
//            let description = NSPersistentStoreDescription()
//            description.url = URL(fileURLWithPath: "/dev/null")
//            description.type = NSInMemoryStoreType
//            let container = NSPersistentContainer(name: modelName)
//            container.persistentStoreDescriptions = [description]
//            container.loadPersistentStores { _, error in
//                if let error = error as NSError? {
//                    fatalError("Unresolved error \(error), \(error.userInfo)")
//                }
//            }
//            return container
//        }()
//}
    
final class TestCoreDataStack: CoreDataStack {
    
    // MARK: - Initializer
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
