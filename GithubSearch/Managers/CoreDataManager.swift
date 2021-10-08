//
//  CoreDataManager.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import Foundation
import CoreData

open class CoreDataStack {
    public static let managedModelName = "GithubSearch"
    public static let managedModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: managedModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public init() { }
    
    public lazy var storeContainer: NSPersistentContainer = {
        let persistentContainer: NSPersistentContainer
        persistentContainer = NSPersistentContainer(name: CoreDataStack.managedModelName, managedObjectModel: CoreDataStack.managedModel)
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        do {
            try persistentContainer.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("###\(#function): Failed to pin viewContext to the current generation:\(error)")
        }
        return persistentContainer
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    public func newDerivedContext() -> NSManagedObjectContext {
        let backgroundContext = storeContainer.newBackgroundContext()
        return backgroundContext
    }
    
    func saveDerivedContex(_ context: NSManagedObjectContext) {
        context.perform {
            do  {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.saveContext(self.mainContext)
        }
    }
    
    func saveContext() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context != mainContext {
            saveDerivedContex(context)
            return
        }
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
