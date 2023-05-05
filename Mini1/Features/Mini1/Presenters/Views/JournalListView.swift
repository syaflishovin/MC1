//
//  JournalListView.swift
//  Mini1
//
//  Created by Jeremy Raymond on 02/05/23.
//

import SwiftUI

struct JournalListView: View {
    @StateObject var vm = JournallViewModel()
    @StateObject var cm = CoreDataUserManager()
    @Namespace var animation
//    @State var filteredJournals: [Date: Journal]?
    
    let colorCalendar = Color(red: 44 / 255, green: 11 / 255, blue: 183 / 255)
    
//    func colorTag(feeling: String) -> Color {
//        if feeling == "love" {
//            return .pink
//        } else if feeling == "sadness" {
//            return .blue
//        } else if feeling == "fear" {
//            return .red
//        } else if feeling == "surprise" {
//            return .yellow
//        } else if feeling == "anger" {
//            return .brown
//        } else if feeling == "joy" {
//            return .black
//        } else {
//            return .mint
//        }
//    }
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack {
                VStack {
                    Section {
                        HStack{
                            let day = Date()
                            Text(vm.extractedDate(date1: day, format: "MMMM"))
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.yellow)
                            }
                            
                        }
                        
                       
                        Section {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 20) {
                                    ForEach(vm.currentWeek, id: \.self) { day in
                                        VStack {
                                            Text("S")
                                                .padding(.bottom, 12)
                                            Text(vm.extractedDate(date1: day, format: "dd"))
                                            if day == vm.currentDay {
//                                                Circle()
//                                                    .frame(width: 10, height: 10)
                                            }
                                            
                                        }
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding()
                                        .background {
                                            Rectangle()
                                                .fill(.yellow)
                                                .opacity( vm.isToday(date2: day) ? 0.8 : 0)
                                        }
                                        .cornerRadius(15)
                                        .onTapGesture {
                                            withAnimation{
                                                vm.currentDay = day
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.white)
                }
                .background(
                    Rectangle()
                        .fill(.purple)
                        .frame(width: 400, height: 275)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .ignoresSafeArea()
                )
                .padding(.bottom, 70)
            }
            
            
            Spacer()
            
            Section {
                if cm.user.journalArray.contains(where: { $0.key == vm.currentDay }) {
                    
                    HStack {
                        VStack {
                            Image("example")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            Text("\(cm.user.journalArray[vm.currentDay]!.wrappedMood)")
                            Spacer()
                        }
                        ScrollView {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(formattedDate(date: cm.user.journalArray[vm.currentDay]!.wrappedDate))")

                                    Spacer()
                                    Button {

                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.blue)
                                    }
                                    Button {

                                    } label: {
                                        Image(systemName: "trash")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.blue)
                                    }
                                }

                                HStack {
                                    ForEach(0..<4) { _ in
                                        Circle()
                                            .frame(width: 25, height: 25)
                                    }
                                }

                                Text("\(cm.user.journalArray[vm.currentDay]!.wrappedTitle)")
                                Text("\(cm.user.journalArray[vm.currentDay]!.wrappedText)")
                                Image("\(cm.user.journalArray[vm.currentDay]!.image)")
                                    .resizable()
                                    .scaledToFit()
                                Image(uiImage: UIImage(data: cm.user.journalArray[vm.currentDay]!.image ?? Data()) ?? UIImage())
                                                  .resizable()
                                                  .scaledToFill()
                                Spacer()
                            }
                        }

                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
                else {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center) {
                            ZStack {
                                Text("You have no entry for this day.")
                                    .multilineTextAlignment(.center)
                                VStack {
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Text("Create your journal for this date")
                                    }
                                    .padding(10)
                                    .frame(width: 300)
                                    .foregroundColor(.white)
                                    .background(.purple)
                                    .cornerRadius(8)
                                }
                                
                            }
                            
                        }
                        .frame(width: 300, height: 250)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 20)
                        Spacer()
                    }
                    
                    
                }
            }
            
            //JournalListView()
            
            Spacer()
            
        }.padding()
    }
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: date)
    }
    
}

struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView()
    }
}
