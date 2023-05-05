//
//  UserViewModel.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 05/05/23.
//

import SwiftUI
import CloudKit

class UserViewModel: ObservableObject {
//    @StateObject var cm = CoreDataUserManager()
    @Published var userName: String = ""
    @Published var isSignedInToiCloud = false
    @Published var permissionStatus: Bool = false
    @Published var error: String = ""
    
    init(){
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
//        seedUser()
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func getiCloudStatus() {
        // ngecek apakah user udah sign in ke icloudnya atau belom'
        CKContainer.default().accountStatus { [weak self] userStatus, errorMessage in
            DispatchQueue.main.async {
                switch userStatus {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .available:
                    self?.isSignedInToiCloud = true
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] userStatus, errorMessage in
            DispatchQueue.main.async {
                if userStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    // dapetin id user
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, errorMessage in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    // discover icloud user
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, errorMessage in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self.userName = name
                }
            }
        }
    }
    
//    func seedUser() {
//        //var count = partner.journalArray.count
//        cm.fetchAllUser()
//        var user = User(context: cm.moc)
//        user.name = userName
//
//        if cm.moc.hasChanges {
////            try? moc.save()
//            cm.stack.save()
//        }
//    }
}
