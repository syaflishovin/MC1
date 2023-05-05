//
//  JournalView.swift
//  MiniChallenge1
//
//  Created by Silvia Pasica on 28/04/23.
//

import SwiftUI

struct JournalView: View {
    @State var journalModel: JournallViewModel = JournallViewModel()
    @Namespace var animation
    @State var selectedDate = Date.now
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            //pinned header
            LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]){
                Section{
                    Text("\(journalModel.currentDay)")
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:15){
                            
                            ForEach(journalModel.currentMonth, id: \.self){ day in
                                if day == selectedDate {
                                    Text("Test")
                                }
                                VStack(spacing: 10){
                                    
                                    Text(journalModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
//                                        .background{
//                                            ZStack{
//                                                if journalModel.isToday(date: day){
//                                                    Capsule()
//                                                        .fill(.blue)
//                                                        .frame(width: 100, height: 130)
//                                                        .opacity(journalModel.isToday(date: day) ? 1 : 0)
//                                                        .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
//                                                }
//                                            }
//                                        }
                                    
                                    
                                    Circle()
                                        .fill(.black)
                                        .frame(width: 70, height: 70)
                                }
                                .frame(width: 70, height: 100)
                                .background{
                                    ZStack{
                                        if journalModel.isToday(date: day){
                                            Capsule()
                                                .fill(.blue)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                        
                                    }
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation{
                                        selectedDate = day
                                        print("-----")
                                        print(day)
                                        print(journalModel.currentDay)
                                        print(journalModel.isToday(date: day))
                                        print("-----")
                                    }
                                }
                                
                            }
                        }
                        .padding()
                    }

                } header: {
                    HStack{
                        let day = Date()
                        Text(journalModel.extractDate(date: day, format: "MMMM"))
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Spacer()
                        
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 22))
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    
    
    
    
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}


//gaktau kepake atau enggak
//extension View{
//    func hLeading()->some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .leading)
//    }
//
//    func hTrailing()->some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .trailing)
//    }
//
//    func hCenter()->some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .center)
//    }
//}

