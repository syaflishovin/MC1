//
//  Journal+CoreDataProperties.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 28/04/23.
//
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var origin: User?
    @NSManaged public var feeling: NSSet?
    @NSManaged public var mood: String?
    @NSManaged public var image: Data?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }

    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedText: String {
        text ?? "Unknown Journal"
    }
    
    public var wrappedDate: Date {
        date ?? Date.now
    }
    
    public var wrappedMood: String {
        mood ?? "Unknown Mood"
    }
    
    public var feelingArray: [Feeling] {
        let array = feeling?.allObjects as [Feeling]
        return array.sorted { $0.wrappedText < $1.wrappedText}
    }

}

// MARK: Generated accessors for feeling
extension Journal {

    @objc(addFeelingObject:)
    @NSManaged public func addToFeeling(_ value: Feeling)

    @objc(removeFeelingObject:)
    @NSManaged public func removeFromFeeling(_ value: Feeling)

    @objc(addFeeling:)
    @NSManaged public func addToFeeling(_ values: NSSet)

    @objc(removeFeeling:)
    @NSManaged public func removeFromFeeling(_ values: NSSet)

}

extension Journal : Identifiable {

}
