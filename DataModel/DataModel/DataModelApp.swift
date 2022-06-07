//
//  DataModelApp.swift
//  DataModel
//
//  Created by Ray WU on 01/06/2022.
//

import SwiftUI

@main
struct DataModelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
