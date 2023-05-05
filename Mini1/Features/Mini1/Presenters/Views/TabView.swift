//
//  TabView.swift
//  AminKelarMini1
//
//  Created by Silvia Pasica on 04/05/23.
//

import SwiftUI

struct TabView: View {
    @State var selectedButton: Int = 0
    
    var body: some View {
        ZStack{
            Color("primaryColor").ignoresSafeArea()
            VStack{
                Spacer()
                ZStack {
                    BottomBar(selectedButton: $selectedButton).background(CurveShape(selectedButton: selectedButton))
                       
                    Button(action: {
                        selectedButton = 3
                        
                    }){
                        VStack{
                            Image(systemName: "plus")
                                .font(.system(size: 35))
                        }
                        .padding()
                    }
                    .foregroundColor(selectedButton == 3 ? Color("primaryColor"): Color(.gray))
                    .background(selectedButton == 3 ? Color("secondaryColor") : Color(.white))
                    .clipShape(Circle())
                    .offset(y: -15)
                    .padding(.leading, 6)
                    
                }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

struct CurveShape: View{
    var selectedButton: Int
    
    var body: some View{
        ZStack{
            Path{ path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 100))
//                path.addArc(center: CGPoint(x: UIScreen.main.bounds.width/2, y: 65), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                path.addLine(to: CGPoint(x:0, y: 100))
            }
            .fill(selectedButton == 1 ? Color("secondaryColor") : Color.white)
            .rotationEffect(.init(degrees: 180))
           
            
            Path{ path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 393/2, y: 0))
                path.addLine(to: CGPoint(x: 393/2, y: 100))
                path.addLine(to: CGPoint(x:0, y: 100))
            }
            .fill(selectedButton == 2 ? Color("secondaryColor"): Color.white )
            .rotationEffect(.init(degrees: 180))
            
            Path{ path in
                let width = 393
                let mid = width/2
                let curve = 65 - 20
                
                path.move(to: CGPoint(x: mid - 60, y: 100))
                
                let to1 = CGPoint(x: mid, y: curve)
                let control1 = CGPoint(x: mid - 40, y: 100)
                let control2 = CGPoint(x: mid - 40, y: curve)
                
                path.addCurve(to: to1, control1: control1, control2: control2)
                
                let to2 = CGPoint(x: mid + 60, y: 100)
                let control3 = CGPoint(x: mid + 40, y: curve)
                let control4 = CGPoint(x: mid + 40, y: 100)
//
                path.addCurve(to: to2, control1: control3, control2: control4)
                path.addLine(to: CGPoint(x:0, y: 100))
            }
            .fill(Color("primaryColor"))
            .rotationEffect(.init(degrees: 180))
        }.ignoresSafeArea()
    }
}

struct BottomBar: View{
    @Binding var selectedButton: Int
    
    var body: some View{
        HStack(alignment: .bottom){
            Button(action: {
                selectedButton = 1
            }){
                ZStack{
                    VStack{
                        Image(systemName: "house.fill")
                            .font(.system(size: 35))
                        Text("Home")
                    }
                    .frame(width: 193)
                    .padding(.top)
                }
            }.foregroundColor(selectedButton == 1 ? Color("primaryColor"): Color(.gray))
            Spacer(minLength: 12)
            
            Button(action: {
                selectedButton = 2
            }){
                ZStack{
                    VStack{
                        Image(systemName: "calendar")
                            .font(.system(size: 35))
                        Text("Journals")
                    }
                    .frame(width: 193)
                    .padding(.top)
                }
            }.foregroundColor(selectedButton == 2 ? Color("primaryColor"): Color(.gray))
        }
        .padding(.bottom)
        .offset(y: 25)

        
    }
}
