//
//  ContentView.swift
//  RayWuCard
//
//  Created by Ray WU on 28/05/2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: RayWuCardDocument

    var body: some View {
        ZStack {//rgba(76, 209, 55,1.0)
            Color(red: 0.13, green: 0.55, blue: 0.45).edgesIgnoringSafeArea(.all)
            VStack {
                Image("raywu").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                Text("Ray WU")
                    .font(Font.custom("TaipeiSansTCBeta-Bold", size: 40))
                    .bold()
                .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                Divider()
                VStack(spacing: 10.0) {
                    InfoView(text: "+44 07415225101", imageName: "phone.fill")
                    InfoView(text: "raywu1988@me.com", imageName: "envelope.fill")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(RayWuCardDocument()))
    }
}


