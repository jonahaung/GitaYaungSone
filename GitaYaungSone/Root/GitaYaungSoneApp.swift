//
//  GitaYaungSoneApp.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 21/5/22.
//

import SwiftUI

@main
struct GitaYaungSoneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegateAdaptor.self) private var appDelegate
    private let persistance = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistance.context)
                .environmentObject(AppSettings.shared)
                .environmentObject(Authenticator.shared)
        }
    }
}
