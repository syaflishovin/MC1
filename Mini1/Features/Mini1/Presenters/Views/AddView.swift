//
//  AddView.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 25/04/23.
//

import SwiftUI
import CoreML

struct AddView: View {
    @StateObject var vm = JournalViewModel()
    @StateObject var cd = CoreDataUserManager()
    var feelings = ["sadness", "joy", "angry", "surprise", "fear"]
    @State var dateSame: Bool = false
    
    var body: some View {
        VStack {
            DatePicker("Pick a date", selection: $vm.date, displayedComponents: .date)
            Text("\(vm.usedDate)")
            Text(dateSame ? "True" : "False")
            if(dateSame) {
                Text("\(CoreDataUserManager().user.journalArray[vm.usedDate]?.wrappedText ?? "Empty")")
                
            }
            else {
                TextEditor(text: $vm.text)
                    .foregroundColor(.secondary)
                    .border(.black)
            }
            
            Text("The text you write is: \(vm.text)")
            Button {
                predictMood(text: vm.text)
            } label: {
                Text("Predict Mood")
            }
            .buttonStyle(.borderedProminent)
            Text("Your mood is: \(vm.mood)")
            Button {
//                cd.addJournal(date: vm.date, feelings: feelings.randomElement()!, text: vm.text)
            } label: {
                Text("Add Journal")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onChange(of: vm.date) { _ in
            let calendar = Calendar.current
            for (key, value) in cd.user.journalArray {
                if calendar.isDate(key, equalTo: vm.date, toGranularity: .day) {
                    print("Selected date matches key: \(value)")
                    dateSame = true
                    break
                }
                else {
                    dateSame = false
                }
            }
        }
    }
    
    func predictMood(text: String) {
        do {
            let config = MLModelConfiguration()
            let model = try MoodAnalysis(configuration: config)
            
            let prediction = try model.prediction(text: text)
            //let prediction = try model.prediction(input: ["happy", "sad"])
            
            vm.mood = prediction.label
        } catch {
            //If predictMood fails
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
