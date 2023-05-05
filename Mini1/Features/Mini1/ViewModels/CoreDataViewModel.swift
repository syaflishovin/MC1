//
//  CoreDataViewModel.swift
//  Mini1
//
//  Created by Jeremy Raymond on 29/04/23.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    static var moc = {
        let dc = CoreDataViewModel()
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
