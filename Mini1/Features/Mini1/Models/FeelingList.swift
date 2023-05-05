//
//  FeelingList.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 05/05/23.
//

import SwiftUI

struct FeelingList: Identifiable{
    let id = UUID()
    let imageName: String
    let text: String
    var selected: Bool
}

struct Feelings{
    static let feel = [
        FeelingList(imageName: "love-comfort", text: "Comfort", selected: false),
        FeelingList(imageName: "joy-happy", text: "Happy", selected: false),
        FeelingList(imageName: "sad-gloomy", text: "Gloomy", selected: false),
        FeelingList(imageName: "anger-irritated", text: "Irritated", selected: false),
        FeelingList(imageName: "fear-anxious", text: "Anxious", selected: false),
        FeelingList(imageName: "surprise-excited", text: "Excited", selected: false),
        FeelingList(imageName: "love-butterflies", text: "Butterflies", selected: false),
        FeelingList(imageName: "fear-panic", text: "Panic", selected: false),
        FeelingList(imageName: "surprise-shocked", text: "Shocked", selected: false),
        FeelingList(imageName: "anger-frustrated", text: "Frustated", selected: false),
        FeelingList(imageName: "joy-enthusiasm", text: "Enthusiasm", selected: false),
        FeelingList(imageName: "sad-lonely", text: "Lonely", selected: false),
    ]
}
