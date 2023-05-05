//
//  JournalDetailView.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 02/05/23.
//

import SwiftUI
import CloudKit

struct JournalDetailView: View {
    @ObservedObject var journal: Journal
    @State private var share: CKShare?
    @State private var showShareSheet = false
    var stack = CoreDataStack.shared
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text(journal.wrappedText)
                        .font(.headline)
                }
            }
            
            Section {
              if let share = share {
                ForEach(share.participants, id: \.self) { participant in
                  VStack(alignment: .leading) {
                    Text(participant.userIdentity.nameComponents?.formatted(.name(style: .long)) ?? "")
                      .font(.headline)
                    Text("Acceptance Status: \(string(for: participant.acceptanceStatus))")
                      .font(.subheadline)
                    Text("Role: \(string(for: participant.role))")
                      .font(.subheadline)
                    Text("Permissions: \(string(for: participant.permission))")
                      .font(.subheadline)
                  }
                  .padding(.bottom, 8)
                }
              }
            } header: {
              Text("Participants")
            }
        }.sheet(isPresented: $showShareSheet, content: {
            if let share = share {
              CloudSharingView(share: share, container: stack.ckContainer, journal: journal)
            }
          })
          .onAppear(perform: {
            self.share = stack.getShare(journal)
          })
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Button {
                if !stack.isShared(object: journal) {
                  Task {
                    await createShare(journal)
                  }
                }
                showShareSheet = true
              } label: {
                Image(systemName: "square.and.arrow.up")
              }
            }
        }
    }
}

extension JournalDetailView {
  private func createShare(_ journal: Journal) async {
    do {
        let (_, share, _) = try await stack.persistentContainer.share([journal], to: nil)
        share[CKShare.SystemFieldKey.title] = journal.wrappedText
      self.share = share
    } catch {
      print("Failed to create share")
    }
  }

  private func string(for permission: CKShare.ParticipantPermission) -> String {
    switch permission {
    case .unknown:
      return "Unknown"
    case .none:
      return "None"
    case .readOnly:
      return "Read-Only"
    case .readWrite:
      return "Read-Write"
    @unknown default:
      fatalError("A new value added to CKShare.Participant.Permission")
    }
  }

  private func string(for role: CKShare.ParticipantRole) -> String {
    switch role {
    case .owner:
      return "Owner"
    case .privateUser:
      return "Private User"
    case .publicUser:
      return "Public User"
    case .unknown:
      return "Unknown"
    @unknown default:
      fatalError("A new value added to CKShare.Participant.Role")
    }
  }

  private func string(for acceptanceStatus: CKShare.ParticipantAcceptanceStatus) -> String {
    switch acceptanceStatus {
    case .accepted:
      return "Accepted"
    case .removed:
      return "Removed"
    case .pending:
      return "Invited"
    case .unknown:
      return "Unknown"
    @unknown default:
      fatalError("A new value added to CKShare.Participant.AcceptanceStatus")
    }
  }

//  private var canEdit: Bool {
//    stack.canEdit(object: destination)
//  }
}


//struct JournalDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        JournalDetailView(journal: journal[0])
//    }
//}
