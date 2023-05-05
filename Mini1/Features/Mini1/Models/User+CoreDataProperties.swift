//
//  User+CoreDataProperties.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 28/04/23.
//
//

import Foundation
import CoreData
import CloudKit


extension User: Identifiable {
    
    public var id: NSManagedObjectID{
        return objectID
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var cloudKitRecordID: String?
    @NSManaged public var name: String?
    @NSManaged public var journal: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown User"
    }
    
    public var journalArray: [Date:Journal] {
        let array = journal?.allObjects as! [Journal]
        let dictionary = Dictionary(uniqueKeysWithValues: array.map {($0.date ?? Date.now, $0)})
        
        return dictionary
    }
    
    func setCloudKitRecordID() {
        let recordName = UUID().uuidString
        let recordID = CKRecord.ID(recordName: recordName)
        cloudKitRecordID = recordID.recordName
    }

}

// MARK: Generated accessors for journal
extension User {

    @objc(addJournalObject:)
    @NSManaged public func addToJournal(_ value: Journal)

    @objc(removeJournalObject:)
    @NSManaged public func removeFromJournal(_ value: Journal)

    @objc(addJournal:)
    @NSManaged public func addToJournal(_ values: NSSet)

    @objc(removeJournal:)
    @NSManaged public func removeFromJournal(_ values: NSSet)

}
