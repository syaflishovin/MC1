//
//  TagView.swift
//  MiniChallenge1
//
//  Created by Silvia Pasica on 28/04/23.
//

import SwiftUI

struct TagView: View {
    var tagText: String
    var tagColor: Color
    
    var body: some View {

        Text(tagText)
            .font(.system(size: 16))
            .fontWeight(.medium)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .foregroundColor(Color(.white))
            .background(tagColor)
            .cornerRadius(20)
            .fixedSize()
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tagText: "stressed", tagColor: .red)
    }
}
