//
//  AuthenticationChecker.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
import FirebaseAuth

private struct AuthenticationCheckerModifier: ViewModifier {
    @State private var isUnAuthenticated = false
    func body(content: Content) -> some View {
        Group {
            if isUnAuthenticated {
                AuthenticateSession()
            }else {
                content
            }
        }
        .task {
            check()
        }
    }
    
    private func check() {
        isUnAuthenticated = Auth.auth().currentUser == nil
    }
}
extension View {
    func authenticatable() -> some View {
        ModifiedContent(content: self, modifier: AuthenticationCheckerModifier())
    }
}
