//
//  GreetingsView.swift
//  Mini1
//
//  Created by Syafli Shovin on 05/05/23.
//

import SwiftUI

struct GreetingsView: View {
    var userName: String
    
    var body: some View {
        VStack{
            // VStack: Section atas
            ZStack{
                Color(.white)
                    .ignoresSafeArea()
                    .frame(width: 389, height: 150)
                    .shadow(color: Color.black.opacity(50), radius: 20, x: 0, y: 2)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Hello,")
                            .font(.system(size: 20))
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight((.light))
                            .multilineTextAlignment(.leading)
                        Text("\(userName)!")
                            .font(.system(size: 34))
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight((.bold))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    //                        .padding(.top, 20)
                    Spacer()
                    Image("half-logo-left")
                        .resizable()
                        .frame(maxWidth: 77, maxHeight: 77)
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

struct GreetingsView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingsView(userName: "Kelvin")
    }
}
