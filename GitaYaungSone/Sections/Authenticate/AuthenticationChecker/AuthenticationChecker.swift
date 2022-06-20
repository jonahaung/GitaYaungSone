//
//  AuthenticationChecker.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

private struct AuthenticationCheckerModifier: ViewModifier {
    
    @EnvironmentObject private var authenticator: Authenticator
    
    func body(content: Content) -> some View {
        Group {
            if authenticator.isLoggedIn {
                content
            }else {
                SignInView()
            }
        }
    }
}

extension View {
    func authenticatable() -> some View {
        ModifiedContent(content: self, modifier: AuthenticationCheckerModifier())
    }
}
