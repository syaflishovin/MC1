//
//  Tag.swift
//  Mini1
//
//  Created by Jeremy Raymond on 30/04/23.
//

import Foundation

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
    
}
