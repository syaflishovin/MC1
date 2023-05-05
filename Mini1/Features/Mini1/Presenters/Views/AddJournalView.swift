//
//  AddJournalView.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 04/05/23.
//

import SwiftUI
import CoreML

struct AddJournalView: View {
    @StateObject var vm = JournalViewModel()
    @StateObject var cd = CoreDataUserManager()
    let defaultImage = UIImage()
 
    @State var dateSame: Bool = false
    @State private var image: Image?
    @State var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var feelings = ["sadness", "joy", "angry", "surprise", "fear"]
    
    let elementColor = Color(red: 206 / 255, green: 214 / 255, blue: 249 / 255)
    let fontColor =  Color(red: 62 / 255, green: 84 / 255, blue: 172 / 255)
    
    var body: some View {
        NavigationView {
            ZStack{
                fontColor.ignoresSafeArea()
                
                VStack{
//                    DatePicker("Pick a date", selection: $vm.date, displayedComponents: .date)
//                    Text("\(vm.usedDate)")
//                    Text(dateSame ? "True" : "False")
                    
                    if(dateSame) {
                        Text("\(CoreDataUserManager().user.journalArray[vm.usedDate]?.wrappedText ?? "Empty")")
                        
                    } else {
                    
                        SelectFeelingView(isOn: false)
                        
                        VStack{
                            Text("How was your day?")
                                .fontWeight(.semibold)
                                .font(.title2).foregroundColor(fontColor)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(elementColor, lineWidth: 1)
                                    .frame(width: 325,height: 100)
                                
                                if image == nil {
                                    Image(systemName: "camera.fill")
                                        .resizable().foregroundColor(elementColor)
                                        .frame(width: 80, height: 60)
                                } else {
                                    Image(systemName: "camera.fill")
                                        .resizable().foregroundColor(elementColor.opacity(0))
                                        .frame(width: 80, height: 60)
                                }
                               

                                image?.resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 325, maxHeight: 100)
                                    .clipped()
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            
                            VStack{
                                TextEditor(text: $vm.text)
                                    .frame(width: 325, height: 160).scrollIndicators(.hidden).disableAutocorrection(true)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                  .stroke(elementColor, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color.white)
                        .cornerRadius(20)
                        .onChange(of: inputImage) { _ in
                            loadImage()
                        }.sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                    
                        Button {
                            //
                            predictMood(text: vm.text)
                            
//                            cd.addJournal(date: vm.date, feelings: feelings.randomElement()!, text: vm.text)
                            cd.addJournal(date: vm.date, feelings: feelings.randomElement()!, text: vm.text, image: inputImage ?? defaultImage)
                            
                        } label: {
                            Text("Save")
                                .frame(width: 358 ,height: 44)
                                .fontWeight(.semibold)
                                .background(elementColor)
                                .foregroundColor(fontColor)
                                .cornerRadius(20)
                        }
                    }
                }
                
            }
//            .frame(width: .infinity, height: .infinity)
//            .background(fontColor).ignoresSafeArea()
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
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView()
    }
}
