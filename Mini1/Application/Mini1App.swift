//
//  Mini1App.swift
//  Mini1
//
//  Created by Jeremy Raymond on 29/04/23.
//

import SwiftUI

@main
struct Mini1App: App {
    let coreDataUserManager = CoreDataUserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //TagHomeView()
            //CalendarView(date: Date())
            //JournalView()
        }
    }
}
