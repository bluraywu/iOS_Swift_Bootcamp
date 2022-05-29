//
//  ContentView.swift
//  HackerNews
//
//  Created by Ray WU on 28/05/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var netManager = NetworkManager()

    var body: some View {
        NavigationView {
            List(netManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text("\(post.points)")
                        Text(post.title)
                    }
                }

            }
                    .navigationBarTitle(Text("Hacker News"))
        }
                .onAppear {
                    netManager.fetchData()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
