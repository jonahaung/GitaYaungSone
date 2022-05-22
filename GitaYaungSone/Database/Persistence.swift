//
//  Persistence.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController()
    private let container: NSPersistentCloudKitContainer
    lazy var context = container.viewContext

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Myanmar_Song_Book")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
}
