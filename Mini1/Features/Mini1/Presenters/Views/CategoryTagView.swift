//
//  CategoryTagView.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 05/05/23.
//

import SwiftUI

struct CategoryTagView: View {
    
    var feeling: FeelingList
    var imageOpacity: Double
    
    var body: some View {

        VStack(alignment: .center){
//
            Image(feeling.imageName)
                .resizable()
                .opacity(imageOpacity)
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                
            Text(feeling.text  )
                .font(.system(size: 14))
                .foregroundColor(Color("primaryColor"))
        }
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTagView(feeling: FeelingList(imageName: "surprise-excited", text: "Excited", selected: false), imageOpacity: 0.4)
    }
}
