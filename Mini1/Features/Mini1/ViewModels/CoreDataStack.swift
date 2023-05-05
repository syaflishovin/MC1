//
//  CoreDataStack.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 29/04/23.
//

import CoreData
import CloudKit

final class CoreDataStack: ObservableObject {
    
//    static var moc = {
//        let cd = CoreDataStack()
//        return cd.context
//    }()
    var ckContainer: CKContainer {
        let storeDescription = persistentContainer.persistentStoreDescriptions.first
        guard let identifier = storeDescription?
            .cloudKitContainerOptions?.containerIdentifier else {
            fatalError("Unable to get container identifier")
        }
        return CKContainer(identifier: identifier)
    }

    static let shared = CoreDataStack()
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // gara gara di taruh di sini jadi bener & muncul recordsnya 
    static var moc = {
//        let cd = CoreDataStack()
        return shared.context
    }()

  var privatePersistentStore: NSPersistentStore {
    guard let privateStore = _privatePersistentStore else {
      fatalError("Private store is not set")
    }
    return privateStore
  }

  var sharedPersistentStore: NSPersistentStore {
    guard let sharedStore = _sharedPersistentStore else {
      fatalError("Shared store is not set")
    }
    return sharedStore
  }

  lazy var persistentContainer: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: "Mini1")

    guard let privateStoreDescription = container.persistentStoreDescriptions.first else {
      fatalError("Unable to get persistentStoreDescription")
    }
    let storesURL = privateStoreDescription.url?.deletingLastPathComponent()
    privateStoreDescription.url = storesURL?.appendingPathComponent("private.sqlite")

    // TODO: 1
      let sharedStoreURL = storesURL?.appendingPathComponent("shared.sqlite")
      guard let sharedStoreDescription = privateStoreDescription
        .copy() as? NSPersistentStoreDescription else {
        fatalError(
          "Copying the private store description returned an unexpected value."
        )
      }
      sharedStoreDescription.url = sharedStoreURL

    // TODO: 2
      guard let containerIdentifier = privateStoreDescription
        .cloudKitContainerOptions?.containerIdentifier else {
        fatalError("Unable to get containerIdentifier")
      }
      let sharedStoreOptions = NSPersistentCloudKitContainerOptions(
        containerIdentifier: containerIdentifier
      )
      sharedStoreOptions.databaseScope = .shared
      sharedStoreDescription.cloudKitContainerOptions = sharedStoreOptions

    // TODO: 3
      container.persistentStoreDescriptions.append(sharedStoreDescription)

    // TODO: 4 // replace this code with code under it

//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        fatalError("Failed to load persistent stores: \(error)")
//      }
//    }
      
      container.loadPersistentStores { loadedStoreDescription, error in
        if let error = error as NSError? {
          fatalError("Failed to load persistent stores: \(error)")
        } else if let cloudKitContainerOptions = loadedStoreDescription
          .cloudKitContainerOptions {
          guard let loadedStoreDescritionURL = loadedStoreDescription.url else {
            return
          }
          if cloudKitContainerOptions.databaseScope == .private {
            let privateStore = container.persistentStoreCoordinator
              .persistentStore(for: loadedStoreDescritionURL)
            self._privatePersistentStore = privateStore
          } else if cloudKitContainerOptions.databaseScope == .shared {
            let sharedStore = container.persistentStoreCoordinator
              .persistentStore(for: loadedStoreDescritionURL)
            self._sharedPersistentStore = sharedStore
          }
        }
      }

      

    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()

  private var _privatePersistentStore: NSPersistentStore?
  private var _sharedPersistentStore: NSPersistentStore?
  private init() {}
}

//final class CoreDataStack: ObservableObject{
//    //
//    static let shared = CoreDataStack()
//
//    var context: NSManagedObjectContext{
//        persistentContainer.viewContext
//    }
//
//    var privatePersistentStore: NSPersistentStore{
//        guard let privateStore = _privatePersistentStore else {
//          fatalError("Private store is not set")
//        }
//        return privateStore
//    }
//
//      var sharedPersistentStore: NSPersistentStore {
//        guard let sharedStore = _sharedPersistentStore else {
//          fatalError("Shared store is not set")
//        }
//        return sharedStore
//      }
//
//    lazy var persistentContainer: NSPersistentCloudKitContainer = {
//      let container = NSPersistentCloudKitContainer(name: "CoreDataPractice3")
//
//      guard let privateStoreDescription = container.persistentStoreDescriptions.first else {
//        fatalError("Unable to get persistentStoreDescription")
//      }
//      let storesURL = privateStoreDescription.url?.deletingLastPathComponent()
//      privateStoreDescription.url = storesURL?.appendingPathComponent("private.sqlite")
//
//      // TODO: 1
//
//      // TODO: 2
//
//      // TODO: 3
//
//      // TODO: 4
//
//      container.loadPersistentStores { _, error in
//        if let error = error as NSError? {
//          fatalError("Failed to load persistent stores: \(error)")
//        }
//      }
//
//      container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//      container.viewContext.automaticallyMergesChangesFromParent = true
//      return container
//    }()
//
//    private var _privatePersistentStore: NSPersistentStore?
//    private var _sharedPersistentStore: NSPersistentStore?
//    private init() {}
//}

extension CoreDataStack{
    func save(){
        if context.hasChanges{
            do{
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
//    func delete(_ student: Student){
//        context.perform {
//            self.context.delete(student)
//            self.save()
//        }
//    }
}

extension CoreDataStack {
    func isShared(object: NSManagedObject) -> Bool {
      isShared(objectID: object.objectID)
    }
    
    func getShare(_ journal: Journal) -> CKShare? {
      guard isShared(object: journal) else { return nil }
        guard let shareDictionary = try? persistentContainer.fetchShares(matching: [journal.objectID]),
              let share = shareDictionary[journal.objectID] else {
        print("Unable to get CKShare")
        return nil
      }
        share[CKShare.SystemFieldKey.title] = journal.wrappedText
      return share
    }
    
    private func isShared(objectID: NSManagedObjectID) -> Bool {
    var isShared = false
    if let persistentStore = objectID.persistentStore {
      if persistentStore == sharedPersistentStore {
        isShared = true
      } else {
        let container = persistentContainer
        do {
          let shares = try container.fetchShares(matching: [objectID])
          if shares.first != nil {
            isShared = true
          }
        } catch {
          print("Failed to fetch share for \(objectID): \(error)")
        }
      }
    }
    return isShared
  }
}

