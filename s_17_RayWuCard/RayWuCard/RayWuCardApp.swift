//
//  RayWuCardApp.swift
//  RayWuCard
//
//  Created by Ray WU on 28/05/2022.
//

import SwiftUI

@main
struct RayWuCardApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: RayWuCardDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
