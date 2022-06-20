//
//  SettingsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var authenticator: Authenticator
    
    var body: some View {
        Form {
            Section {
                if let user = authenticator.currentUser {
                    FormCell2 {
                        Text("user")
                    } right: {
                        Text(user.email ?? "Annoymous")
                    }
                    .tapToPush(SettingsUserProfile())
                } else {
                    Text("Sign In")
                        .tapToPush(SignInView())
                }
            }
            
            Section {
                Button("Developer Action") {
                    Developer.upDateArtists()
                }
            }
        }
        .navigationTitle("Settings")
        .embeddedInNavigationView()
    }
}
