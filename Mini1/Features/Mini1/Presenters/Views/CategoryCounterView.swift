//
//  CategoryCounterView.swift
//  Mini1
//
//  Created by Syafli Shovin on 04/05/23.
//

import SwiftUI

struct CategoryCounterView: View {
    var feeling: FeelingList
    var counter: Int
    
    var body: some View {
        VStack{
            ZStack{
                Image(systemName: "circle.fill")
                    .foregroundColor((Color("lightPurple")))
                    .frame(width: 19.19, height: 19.19)
                    .padding(.bottom, 40)
                    .padding(.leading, 30)
                
                Image(feeling.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38, height: 38)
                
                Text("\(counter)")
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .padding(.bottom, 40)
                    .padding(.leading, 30)
            }
            
            Text(feeling.text)
                .font(.system(size: 10))
                .fontWeight(.regular)
                .foregroundColor((Color("primaryColor")))
                .padding(.top, -15)
        }
    }
}

struct CategoryCounterView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCounterView(feeling: FeelingList(imageName: "surprise-excited", text: "Excited", selected: false), counter: 2)
    }
}
