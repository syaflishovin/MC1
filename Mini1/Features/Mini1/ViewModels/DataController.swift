//
//  DataController.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 28/04/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static var moc = {
        let dc = DataController()
        return dc.container.viewContext
    }()
    
    private let container = NSPersistentContainer(name: "Mini1")
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
