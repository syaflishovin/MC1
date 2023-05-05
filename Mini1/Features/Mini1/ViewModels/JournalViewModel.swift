//
//  JournalViewModel.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 27/04/23.
//

import Foundation
import SwiftUI
import CoreData

class JournalViewModel: ObservableObject {
//    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
//    @Environment(\.managedObjectContext) var moc
     //@ObservedObject var userManager = CoreDataUserManager()
    
//    var user: User
//    var partner: User
    
    //UI Control
    @Published var image: UIImage?
    @Published var text: String = ""
    @Published var mood: String = "Mood"
    @Published var date: Date = Date.now
    @Published var feeling: [String] = ["joy", "sadness", "fear", "surprise", "anger"]
    
    var usedDate: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let dateWithoutTime = calendar.date(from: dateComponents)!
        return dateWithoutTime
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    func isSameDate(date1: Date, date2: Date)->Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)

        let sameDate = components1.year == components2.year &&
                       components1.month == components2.month &&
                       components1.day == components2.day

        return sameDate
    }
    
    
//    init() {
//        user = User()
//        partner = User()
//        if users.count >= 2 {
//            user = users[0]
//            partner = users[1]
//        }
//    }
}
