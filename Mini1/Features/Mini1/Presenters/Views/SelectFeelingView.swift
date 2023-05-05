//
//  SelectFeelingView.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 04/05/23.
//

import SwiftUI

struct SelectFeelingView: View {
    @StateObject var cd = CoreDataUserManager()
    private let columns =
    [GridItem(.adaptive(minimum: 75, maximum: 75), spacing: 8.0)]
    @State var isOn: Bool
    @State var feelingList: [FeelingList] = Feelings.feel
    
    var body: some View {
        VStack {
            Text("What have you been up to?")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("primaryColor"))
                .padding(.vertical)
            LazyVGrid(columns: columns){
                //minta tolong masukin datanya dalam foreach ajaa ya, thx <3
//                ForEach(cd.user.journalArray) { journal in
//                    ForEach(journal.feelingArray) {
//
//                    }
////                    CardSelectFeeling(data: feeling, isOn: isOn)
////                    Circle().frame(width: 25, height: 25)
//                }
                ForEach(feelingList){ feel in
                    CardSelectFeeling(isOn: isOn, data: feel)
                }
                
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}

struct CardSelectFeeling: View{
    @State var isOn: Bool
    @State var data: FeelingList
    
    var body: some View{
        Button(action: {
            isOn.toggle()
            self.data.selected = true
        }){
            CategoryTagView(feeling: self.data, imageOpacity: isOn ? 1.0 : 0.3)
        }
    }
}

struct SelectFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFeelingView(isOn: false)
    }
}
