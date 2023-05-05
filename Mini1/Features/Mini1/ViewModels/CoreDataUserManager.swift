//
//  CoreDataUserManager.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 28/04/23.
//

import Foundation
import CoreData
import CloudKit
import UIKit

class CoreDataUserManager: ObservableObject {
    
//    @Published var userName: String = ""
//    @Published var isSignedInToiCloud = false
//    @Published var permissionStatus: Bool = false
//    @Published var error: String = ""
    
    @Published var users: [User] = []
//    var moc = DataController.moc
    var moc = CoreDataStack.moc
    var stack = CoreDataStack.shared
    
    var user = User()
    var partner = User()
    
    public func fetchAllUser(){
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users = try? moc.fetch(request) else { return }
        self.users = users
        
        if !users.isEmpty {
            user = users[0]
            partner = users[1]
        }
    }
    
    public func addJournal(date: Date, feelings: String, text: String, image: UIImage) {
        var journal = Journal(context: moc)
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let dateWithoutTime = calendar.date(from: dateComponents)!
        journal.date = dateWithoutTime
        
        let moods = ["joy", "sadness", "surprise", "fear", "anger"]
        
        journal.title = "Example Title"
        journal.text = text
        journal.mood = moods.randomElement()!
        journal.origin = user
        
        let imageData = image.jpegData(compressionQuality: 0.8)
        journal.image = imageData
        
        if moc.hasChanges {
//            try? moc.save()
            stack.save()
        }
        
        let types = ["Physical", "Mind", "Social", "Work"]
        let feelings = ["need rest", "a bit sick", "stress", "anxious", "empty", "over thinks a lot", "drain out", "overwhelmed", "bored", "have a lot in mind", "worried sick", "not in the mood", "wants to be left alone", "wanderlust", "wants to travel", "wants to stay at home", "fidgety"]
        
        addFeelings(journal: journal, texts: [feelings.randomElement()!, feelings.randomElement()!, feelings.randomElement()!], moods: [types.randomElement()!, types.randomElement()!, types.randomElement()!])
    }
    
    public func addFeeling(journal: Journal, text: String, mood: String) {
        let feeling = Feeling(context: moc)
        feeling.text = text
        feeling.type = mood
        feeling.origin = journal
        
        if moc.hasChanges {
//            try? moc.save()
            stack.save()
        }
    }
    
    public func addFeelings(journal: Journal, texts: [String], moods: [String]) {
        for count in 0..<texts.count {
            addFeeling(journal: journal, text: texts[count], mood: moods[count])
        }
    }
    
    public func seedNewData(){
        if users.isEmpty {
            let user = User(context: moc)
            user.name = "User name"
            user.setCloudKitRecordID()
            
            let partner = User(context: moc)
            partner.name = "Partner Name"
            
            if moc.hasChanges {
//                try? moc.save()
                stack.save()
                users.append(user)
            }
            
            seedPartner()
            seedPartner()
            seedPartner()
        }
    }
    
    public func seedPartner() {
        //var count = partner.journalArray.count
        fetchAllUser()
        var journal = Journal(context: moc)
        journal.text = "Partner Journal"
        //journal.text = "Journal Partner \(count)"
        journal.date = Date.now
        journal.origin = partner
        
        if moc.hasChanges {
//            try? moc.save()
            stack.save()
        }
    }
    
    
    
    init() {
        //deleteAll()
        fetchAllUser()
//        getiCloudStatus()
//        requestPermission()
//        fetchiCloudUserRecordID()
        seedNewData()
    }
    
//    enum CloudKitError: String, LocalizedError {
//        case iCloudAccountNotFound
//        case iCloudAccountNotDetermined
//        case iCloudAccountRestricted
//        case iCloudAccountUnknown
//    }
    
//    func getiCloudStatus() {
//        // ngecek apakah user udah sign in ke icloudnya atau belom'
//        CKContainer.default().accountStatus { [weak self] userStatus, errorMessage in
//            DispatchQueue.main.async {
//                switch userStatus {
//                case .couldNotDetermine:
//                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
//                case .available:
//                    self?.isSignedInToiCloud = true
//                case .restricted:
//                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
//                case .noAccount:
//                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
//                default:
//                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
//                }
//            }
//        }
//    }
    
//    func requestPermission() {
//        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] userStatus, errorMessage in
//            DispatchQueue.main.async {
//                if userStatus == .granted {
//                    self?.permissionStatus = true
//                }
//            }
//        }
//    }
    
    // dapetin id user
//    func fetchiCloudUserRecordID() {
//        CKContainer.default().fetchUserRecordID { [weak self] returnedID, errorMessage in
//            if let id = returnedID {
//                self?.discoveriCloudUser(id: id)
//            }
//        }
//    }
    
    // discover icloud user
//    func discoveriCloudUser(id: CKRecord.ID) {
//        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, errorMessage in
//            DispatchQueue.main.async {
//                if let name = returnedIdentity?.nameComponents?.givenName {
//                    self.userName = name
//                }
//            }
//        }
//    }
    
    
    func deleteAll() {
          let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
          let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? moc.execute(batchDeleteRequest1)
        users.removeAll()
    }
    
}
