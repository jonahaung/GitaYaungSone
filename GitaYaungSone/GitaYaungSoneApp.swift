//
//  GitaYaungSoneApp.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 21/5/22.
//

import SwiftUI

@main
struct GitaYaungSoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
