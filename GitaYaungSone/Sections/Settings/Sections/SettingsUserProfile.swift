//
//  SettingsUserProfile.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 27/5/22.
//

import SwiftUI
struct SettingsUserProfile: View {

    @EnvironmentObject private var authenticator: Authenticator
    
    var body: some View {
        Form {
            
            Section {
                if let email = authenticator.currentUser?.email {
                    Text(email)
                    Text("Admin Edit")
                        .tapToPush(AdminPannelView())
                }
            }

            Section("Admin Pannel") {
                Button("Sign Out") {
                    Task {
                        await authenticator.signOut()
                    }
                }.frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("User Profile")
    }
}
