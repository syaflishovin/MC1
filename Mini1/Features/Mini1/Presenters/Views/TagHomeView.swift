//
//  TagHomeView.swift
//  Mini1
//
//  Created by Jeremy Raymond on 30/04/23.
//

import SwiftUI

struct TagHomeView: View {
    @State var text: String = ""
    @State var tags: [Tag] = []
    
    var body: some View {
        VStack {
            Text("Filter \nMenus")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //Custom Tag View
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 200)
            
            //Text Field
            TextField("apple", text: $text)
                .font(.title3)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                        
                )
            //Setting only text field as dark
                .environment(\.colorScheme, .dark)
            //Add Button
            Button {
                tags.append(addTag(text: text, fontSize: 16))
                text = ""
            } label: {
                Text("Add Tag")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 45)
                    .background(.white)
                    .cornerRadius(20)
            }
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.blue)
    }
}

struct TagHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TagHomeView()
    }
}
