//
//  HomeView.swift
//  MiniChallenge1
//
//  Created by Jeremy Raymond on 25/04/23.
//

import SwiftUI

struct HomeView: View {
    
    
////    @StateObject var uservm = UserViewModel()
//    @StateObject var cd = CoreDataUserManager()
//    @StateObject var rec = Recommendation()
//
//    @State private var isLiked = false
//    @State private var isDisliked = false
//
//    func colorTag(feeling: String) -> Color {
//        if feeling == "Work" {
//            return .pink
//        } else if feeling == "Physical" {
//            return .blue
//        } else if feeling == "Social" {
//            return .red
//        } else if feeling == "Mind" {
//            return .yellow
//        } else {
//            return .mint
//        }
//    }
//
    var body: some View {
        
//        ZStack{
////            .frame(maxWidth: .infinity, maxHeight: .infinity)
////            .background(Color("primaryColor"))
//        }
        
        VStack{
            GreetingsView(userName: "Kelvin")
//                .padding(.bottom, )
            WeeklyRecapView()
//                .padding(.top, 20)
            SuggestionsView()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("primaryColor"))
//        VStack(alignment: .leading) {
//            Image("profile")
//                .resizable()
////                .aspectRatio(contentMode: .fill)
//                .frame(height: 250)
//
//            VStack(alignment: .leading){
//                Text("Hello,")
//                    .font(.system(size: 30))
//                    .fontWeight(.medium)
//                    .foregroundColor(Color(.white))
//                Text("Puan Maharani")
//                    .font(.system(size: 43))
//                    .fontWeight(.bold)
//                    . foregroundColor(Color(.white))
//
//                //recap
//                Text("Here's your weekly recap, ")
//                    .font(.system(size: 19))
//                    .fontWeight(.medium)
//                    .foregroundColor(Color(.white))
//                    .padding(.top, 2)
//                if !rec.feelingCounts.isEmpty {
//                    WrappingHStack(alignment: .leading) {
//                        //buat for each
//                        ForEach(rec.feelingCounts.sorted(by: { $0.value > $1.value }).prefix(5), id: \.key) { item in
//                            TagView(tagText: "\(item.key.wrappedText)", tagColor: colorTag(feeling: item.key.wrappedType))
//                        }
//                    }
//                    .padding(.bottom)
//                }
//
//
//
//                Divider()
//                    .frame(height: 2)
//                    .background(Color(.white))
//
//                //suggestion
//                Text("Here's our suggestion for you,")
//                    .font(.system(size: 19))
//                    .fontWeight(.medium)
//                    .foregroundColor(Color(.white))
//                    .padding(.top, 2)
//                if let maxEntry = rec.moodCounts.max(by: { $0.value < $1.value }) {
//                    let maxKey = maxEntry.key
//                    Text(maxKey)
//                }
//                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id mauris a nibh tristique tincidunt. Praesent eu arcu vitae mauris tristique ullamcorper sed in purus.")
//                    .padding(.all, 8)
//                    .font(.system(size: 14))
//                    .foregroundColor(Color("darkBlue"))
//                    .background(Color(.white))
//                    .cornerRadius(15)
//
//                //feedback - like dislike
//                HStack{
//                    Text("Does our insight helpful?")
//                        .font(.system(size: 19))
//                        .fontWeight(.medium)
//                        .foregroundColor(Color(.white))
//                        .padding(.top, 2)
//                    Button(action: {
//                        self.isLiked.toggle()
//                        if self.isDisliked {
//                            self.isDisliked.toggle()
//                        }
//                    }) {
//                        Text("👍")
//                    }
//                    Button(action: {
//                        self.isDisliked.toggle()
//                        if self.isLiked {
//                            self.isLiked.toggle()
//                        }
//                    }) {
//                        Text("👎")
//                    }
//                }
//
//
//            }
//            .padding(.horizontal)
//
//
//
//
//
//            Spacer()
//        }
//        .edgesIgnoringSafeArea(.top)
//        .background(Color("darkBlue"))
//        .onAppear() {
//            rec.getDate(dict: cd.user.journalArray)
//        }
//
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
