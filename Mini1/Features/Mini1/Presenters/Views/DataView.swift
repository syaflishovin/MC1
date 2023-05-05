//
//  DataView.swift
//  Mini1
//
//  Created by Jeremy Raymond on 29/04/23.
//

import SwiftUI

struct DataView: View {
    @StateObject var cd = CoreDataUserManager()
    @StateObject var rec = Recommendation()
    
    var body: some View {
        VStack {
            if !cd.users.isEmpty {
                Text(cd.user.wrappedName)
                Text(cd.partner.wrappedName)
                Text("-------")
                let journals = cd.user.journalArray
                Text("\(cd.users.count)")
                Text("\(journals.count)")
                Text("\(cd.partner.journalArray.count)")
                ForEach(journals.keys.sorted(), id: \.self) { key in
                    if let value = journals[key] {
                        Text("\(key): \(value.wrappedText), mood: \(value.wrappedMood)")
                    }
                    let feelings = journals[key]!.feelingArray
                    ForEach(0 ..< feelings.count) { feelingCount in
                        Text("\(feelings[feelingCount].wrappedText)")
                        Text("\(feelings[feelingCount].wrappedType)")
                    }
                }
            }
            Button("Delete all") {
                cd.deleteAll()
            }
            .buttonStyle(.borderedProminent)
            Button("Test Recommendation") {
                rec.getDate(dict: cd.user.journalArray)
                
                //cd.seedNewData()
            }
            .buttonStyle(.borderedProminent)
        }.onAppear{
            cd.fetchAllUser()
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
