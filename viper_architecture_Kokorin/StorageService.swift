//
//  StorageService.swift
//  TemplateProject
//
//  Created by Pavel Pronin on 29/04/2017.
//  Copyright © 2017 Live Typing. All rights reserved.
//

import Foundation
import CoreData
import Sync

class StorageService {
    
    static let shared = StorageService()
    
    // MARK: - MAIN STACK
    
    public lazy var dataStack: DataStack = DataStack(modelName: "viper_architecture_Kokorin")
    public lazy var memoryDataStack: DataStack = DataStack(modelName: "viper_architecture_Kokorin", bundle: Bundle.main, storeType: .inMemory)
    
    // MARK: - MAIN VIEW CONTEXT
    
    static var viewContext: NSManagedObjectContext {
        get {
            return shared.dataStack.viewContext
        }
        set {}
    }
    
    static var viewMemoryContext: NSManagedObjectContext {
        get {
            return shared.memoryDataStack.viewContext
        }
        set {}
    }
    
    init() {
        setupNotificationHandling()
        
    }
    
    // MARK: - Helper Methods
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.willTerminateNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // MARK: - Actions
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
    }
    
    // MARK: - Notification Handling
    
    @objc func saveChanges(_ notification: NSNotification? = nil) {
        managedObjectContext.perform {
            do {
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
            
            self.privateManagedObjectContext.perform {
                do {
                    if self.privateManagedObjectContext.hasChanges {
                        try self.privateManagedObjectContext.save()
                    }
                } catch {
                    let saveError = error as NSError
                    print("Unable to Save Changes of Private Managed Object Context")
                    print("\(saveError), \(saveError.localizedDescription)")
                }
            }
            
        }
    }
    
    // MARK: - Core Data stack
    
    fileprivate lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "viper-architecture-Kokorin", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()
    
    lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}

// MARK: - Core Data support

extension StorageService {
    
    func controllerForRequest(request: NSFetchRequest<NSFetchRequestResult>, keyPath: String?=nil) -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let controller = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: keyPath, cacheName: nil)
        
        do {
            _ = try controller.performFetch()
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return controller
    }
    
    func fetchObjectsForRequest(request: NSFetchRequest<NSFetchRequestResult>) -> [AnyObject]? {
        var fetchedObjects: [AnyObject]?
        do {
            fetchedObjects = try StorageService.shared.managedObjectContext.fetch(request)
        } catch {
            print(error)
        }
        return fetchedObjects ?? nil
    }
    
    func removeAllData() {
//        removeAllDefaults()
//        removeAllFromKeychain()
//        removeAllFiles()
//        setAppFirstTimeStarted(true)
        
        //use it to delete entity
        //        let deleteEntity = {(request: NSFetchRequest<NSFetchRequestResult>) -> Void in
        //            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        //            do {
        //                try self.managedObjectContext .execute(batchDeleteRequest)
        //            } catch {
        //                print("Error while delete entity")
        //            }
        //        }
        //        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: .entityName)
        //        deleteEntity(fetchRequest)
        //        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: .entityName)
        //        deleteEntity(fetchRequest)
    }
}
