//
//  Feeling+CoreDataProperties.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 28/04/23.
//
//

import Foundation
import CoreData


extension Feeling {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feeling> {
        return NSFetchRequest<Feeling>(entityName: "Feeling")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var type: String?
    @NSManaged public var origin: Journal?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }

    public var wrappedText: String {
        text ?? "Unknown Feeling"
    }
    
    public var wrappedType: String {
        type ?? "Unknown Type"
    }
    
    
}

extension Feeling : Identifiable {

}
