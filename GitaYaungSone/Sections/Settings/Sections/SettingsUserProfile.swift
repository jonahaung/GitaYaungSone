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
            if let email = authenticator.currentUser?.email {
                Text(email)
            }
            Button("Sign Out") {
                Task {
                    await authenticator.signOut()
                }
            }
        }
        .navigationTitle("User Profile")
    }
}
