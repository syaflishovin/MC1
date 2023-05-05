//
//  CloudSharingController.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 02/05/23.
//

import CloudKit
import SwiftUI

struct CloudSharingView: UIViewControllerRepresentable {
  let share: CKShare
  let container: CKContainer
  let journal: Journal

  func makeCoordinator() -> CloudSharingCoordinator {
    CloudSharingCoordinator(journal: journal)
  }

  func makeUIViewController(context: Context) -> UICloudSharingController {
      share[CKShare.SystemFieldKey.title] = journal.wrappedText
    let controller = UICloudSharingController(share: share, container: container)
    controller.modalPresentationStyle = .formSheet
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {
  }
}

final class CloudSharingCoordinator: NSObject, UICloudSharingControllerDelegate {
  let stack = CoreDataStack.shared
  let journal: Journal
  init(journal: Journal) {
      self.journal = journal
  }

  func itemTitle(for csc: UICloudSharingController) -> String? {
      journal.wrappedText
  }

  func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
    print("Failed to save share: \(error)")
  }

  func cloudSharingControllerDidSaveShare(_ csc: UICloudSharingController) {
    print("Saved the share")
  }

//  func cloudSharingControllerDidStopSharing(_ csc: UICloudSharingController) {
//    if !stack.isOwner(object: journal) {
//      stack.delete(journal)
//    }
//  }
}
