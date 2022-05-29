//
//  DetailView.swift
//  HackerNews
//
//  Created by Ray WU on 29/05/2022.
//
//

import SwiftUI

struct DetailView: View {
    let url: String?

    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "http://google.co.uk")
    }
}



