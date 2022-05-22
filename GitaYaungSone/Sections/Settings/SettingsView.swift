//
//  SettingsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        Form {
            Button("Developer Action") {
                Developer.upDateArtists()
            }
        }
        .navigationTitle("Settings")
        .embeddedInNavigationView()
    }
}
