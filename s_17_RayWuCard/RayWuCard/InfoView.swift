//
//  InfoView.swift
//  RayWuCard
//
//  Created by Ray WU on 28/05/2022.
//

import SwiftUI

struct InfoView: View {
    let text:String
    let imageName:String
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0).fill(.white).frame(height: 50)
            .overlay {
                HStack {
                    Image(systemName: imageName)
                    Text(text)
                }
                
            }
            .padding(.horizontal)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Test", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
