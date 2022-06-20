//
//  AuthenticateSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct SignInView: View {
    
    enum ViewType: String, CaseIterable {
        case SignIn, Register
    }
    @EnvironmentObject private var authenticator: Authenticator
    @State private var viewType = ViewType.SignIn
    
    @State private var email = ""
    @State private var password = ""
    @State private var retypePassword = ""
    
    var body: some View {
        Form {
            if authenticator.showLoading {
                ProgressView()
            } else {
                Section {
                    switch viewType {
                    case .SignIn:
                        emailTextField()
                        passwordTextField()
                    case .Register:
                        emailTextField()
                        passwordTextField()
                        retypePasswordTextField()
                    }
                } header: {
                    Picker("", selection: $viewType) {
                        ForEach(ViewType.allCases, id: \.self) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            
            Button("Sign In") {
                Task {
                    await authenticator.signIn(with: email, password)
                }
            }
            .frame(maxWidth: .infinity)
            .disabled(email.isWhitespace || password.isWhitespace )
            
            Button("Sign In Annoymously") {
                Task {
                    await authenticator.signIn()
                }
            }
        }
        .navigationTitle(viewType.rawValue)
        .alert(authenticator.error, isPresented: $authenticator.showErrorAlert) {
            Button("Ok") { }
        }
    }
    
    
    private func emailTextField() -> some View {
        TextField("Email", text: $email)
            .textContentType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
    private func passwordTextField() -> some View {
        SecureField("Password", text: $password)
            .textContentType(.password)
    }
    
    private func retypePasswordTextField() -> some View {
        SecureField("Retype Password", text: $retypePassword)
            .textContentType(.password)
    }
}
