//
//  ContentView.swift
//  I am Rich
//
//  Created by Ray WU on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(.systemTeal).edgesIgnoringSafeArea(.all)
            VStack {
                Text("I am Rich").font(.system(size: 40)).fontWeight(.bold).foregroundColor(Color.white)
                Image("diamond").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
            }
            //.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
