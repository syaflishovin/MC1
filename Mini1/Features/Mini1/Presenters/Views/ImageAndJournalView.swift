//
//  ImageAndJournalView.swift
//  Mini1
//
//  Created by Anisya Dewi Larasati on 04/05/23.
//

import SwiftUI
import PhotosUI

struct ImageAndJournalView: View {
    
    @StateObject var vm = JournalViewModel()
    @State private var image: Image?
    @State var inputImage: UIImage?
//    @State private var text: String = ""
    @State private var showingImagePicker = false
    
    let elementColor = Color(red: 206 / 255, green: 214 / 255, blue: 249 / 255)
    let fontColor =  Color(red: 62 / 255, green: 84 / 255, blue: 172 / 255)

    
    var body: some View {
//        NavigationView {
            VStack{
                Text("How was your day?")
                    .fontWeight(.semibold)
                    .font(.title2).foregroundColor(fontColor)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(elementColor, lineWidth: 1)
                        .frame(width: 325,height: 100)
                    
                    if image == nil {
                        Image(systemName: "camera.fill")
                            .resizable().foregroundColor(elementColor)
                            .frame(width: 80, height: 60)
                    } else {
                        Image(systemName: "camera.fill")
                            .resizable().foregroundColor(elementColor.opacity(0))
                            .frame(width: 80, height: 60)
                    }
                   

                    image?.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 325, maxHeight: 100)
                        .clipped()
                }
                .padding(.horizontal)
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack{
                    TextEditor(text: $vm.text)
                        .frame(width: 325, height: 160).scrollIndicators(.hidden).disableAutocorrection(true)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(elementColor, lineWidth: 1)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color.white)
            .cornerRadius(20)
            .onChange(of: inputImage) { _ in
                loadImage()
            }.sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct ImageAndJournalView_Previews: PreviewProvider {
//    @State static var inputImage: UIImage?
    static var previews: some View {
        ImageAndJournalView()
    }
}
