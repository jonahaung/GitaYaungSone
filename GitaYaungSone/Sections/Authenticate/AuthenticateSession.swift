//
//  AuthenticateSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthenticateSession: View {
    
    @StateObject  private var authenticator = Authenticator.shared
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                TextField("Password", text: $password)
                    .textContentType(.password)
                Button("Sign In") {
                    signIn()
                }.disabled(email.isWhitespace || password.isWhitespace )
            }
        }
        .navigationTitle("Log in")
        .embeddedInNavigationView(showCancelButton: true)
    }
    
    private func signIn() {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password)
        authenticator.isUnAuthenticated = false
    }
}
