//
//  CategoryWeeklyRecap.swift
//  Mini1
//
//  Created by Syafli Shovin on 05/05/23.
//

import SwiftUI

struct WeeklyRecapView: View {
    @StateObject var cd = CoreDataUserManager()
    private let columns =
    [GridItem(.adaptive(minimum: 40, maximum: 66), spacing: 16.0)]
//    @State var isOn: Bool
    @State var feelingList: [FeelingList] = Feelings.feel
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Here's your weekly recap")
                    .font(.system(size: 19))
                    .foregroundColor((Color.white.opacity(0.7)))
                //                    .foregroundColor(Color.red)
                    .fontWeight((.medium))
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.leading, 16)
//            .padding(.bottom, -10)
//            .padding(.top, 18)
            
            ZStack{
                Color(.white)
                    .frame(maxWidth: 358, maxHeight: 320)
                    .cornerRadius(15)
                
                VStack{
                    HStack{
                        Text("You feel the most")
                            .font(.system(size: 15))
                            .fontWeight((.regular))
                            .foregroundColor(Color("primaryColor"))
                        + Text(" Excited")
                            .font(.system(size:15))
                            .fontWeight((.bold))
                            .foregroundColor(Color("primaryColor"))
                        + Text(" this week!")
                            .font(.system(size: 15))
                            .fontWeight((.regular))
                            .foregroundColor(Color("primaryColor"))
                    }
                    .padding(.top, 25)
                    
                    LazyVGrid(columns: columns){
                        
                        ForEach(feelingList){ feel in
                            CardWeeklyRecap(data: feel)
                        }
                        
                    }
                    .frame(maxWidth: 225)
                    ButtonFullJourney()
//                    ZStack{
//                        Color("lightPurple")
//                            .frame(maxWidth: 358, maxHeight: 46)
//                            .cornerRadius(15)
//
//                    }
                    .padding([.leading, .trailing], 15)
        //            .padding(.top, 0)
                    
                }
            }
        }
        
//        .frame(maxWidth: 358, maxHeight: 400)
//                .background(Color(.brown))
//                .cornerRadius(15)
        ////        .padding([.leading, .trailing], 15)
        //        .padding(15)
        
//        .frame(maxWidth: 358, maxHeight: 400)
//        .background(Color(.brown))
//        .cornerRadius(15)
////        .padding([.leading, .trailing], 15)
//        .padding(15)
        
    }
    
    struct CardWeeklyRecap: View{
        @State var data: FeelingList
        
        var body: some View{
            CategoryCounterView(feeling: self.data, counter: 2)
        }
    }
    
    
    struct ButtonFullJourney: View {
        var body: some View{
            Button(action: {
                
            }){
                HStack{
                    Text("Go to Second Screen")
                        .foregroundColor((Color("primaryColor")))
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Text(">")
                        .foregroundColor((Color("primaryColor")))
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                }
                .padding(.all)
                .background(Color("lightPurple"))
                .cornerRadius(15)
            }
        }
    }
    
    struct CategoryWeeklyRecapView_Previews: PreviewProvider {
        static var previews: some View {
            WeeklyRecapView()
        }
    }
}
