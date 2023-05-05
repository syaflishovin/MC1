//
//  TagView.swift
//  Mini1
//
//  Created by Jeremy Raymond on 30/04/23.
//

import SwiftUI

struct TagView: View {
    var maxLimit: Int
    @Binding var tags: [Tag]
    
    var title: String = "Add Some Tags"
    var fontSize: CGFloat = 16
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(getRows(), id: \.self) { rows in
                    HStack(spacing: 6) {
                        ForEach(rows) { row in
                            RowView(tag: row)
                        }
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
            .padding(.vertical)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.white.opacity(0.15), lineWidth: 1)
        )
//        .onChange(of: tags) { newValue in
//            guard let last = tags.last else {
//                return
//            }
//
//            let font = UIFont.systemFont(ofSize: 16)
//            let attributes = [NSAttributedString.Key.font: font]
//            let size = (last.text as NSString).size(withAttributes: attributes)
//
//            print(size)
//            tags[getIndex(tag: last)].size = size.width
//        }
        .animation(.easeInOut, value: tags)
    }
    
    @ViewBuilder
    func RowView(tag: Tag)->some View {
        Text(tag.text)
            .font(.system(size: fontSize))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.white)
            )
            .foregroundColor(.blue)
            .lineLimit(1)
            .contentShape(Capsule())
            .contextMenu {
                Button("Delete") {
                    tags.remove(at: getIndex(tag: tag))
                }
            }
    }
    
    func getIndex(tag: Tag)->Int {
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    func getRows()->[[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach { tag in
            totalWidth += (tag.size + 40)
            if totalWidth > screenWidth {
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            }
            else {
                currentRow.append(tag)
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagHomeView()
    }
}

func addTag(text: String, fontSize: CGFloat)->Tag {
    let font = UIFont.systemFont(ofSize: 16)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    
    return Tag(text: text, size: size.width)
}
