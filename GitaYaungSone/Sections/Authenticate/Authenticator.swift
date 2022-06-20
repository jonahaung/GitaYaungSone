//
//  Authenticator.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation
import FirebaseAuth

class Authenticator: ObservableObject {
    
    static let shared = Authenticator()
    
    @Published var currentUser : User? = nil
    @Published var error = ""
    @Published var showErrorAlert = false
    @Published var showLoading = false
    var isLoggedIn: Bool { currentUser != nil }
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        handler = Auth.auth().addStateDidChangeListener{ [weak self] auth, user in
            guard let self  = self else { return }
            print(auth)
            self.currentUser = user
        }
        
    }
    
    func signIn(with email: String,_ password: String) async {
        showLoading = true
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async { [weak self] in
                self?.showLoading = false
            }
        }catch{
            DispatchQueue.main.async { [weak self] in
                self?.error = error.localizedDescription
                self?.showErrorAlert = true
                self?.showLoading = false
            }
        }
    }
    func signIn() async {
        showLoading = true
        do{
            try await Auth.auth().signInAnonymously()
            DispatchQueue.main.async { [weak self] in
                self?.showLoading = false
            }
        }catch{
            DispatchQueue.main.async { [weak self] in
                self?.error = error.localizedDescription
                self?.showErrorAlert = true
                self?.showLoading = false
            }
        }
    }
    func register(with email: String,_ password: String) async {
        do{
            try await Auth.auth().createUser(withEmail: email, password: password)
        }catch{
            DispatchQueue.main.async { [weak self] in
                self?.error = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
    
    func signOut() async {
        do{
            try Auth.auth().signOut()
        }catch{
            self.error = error.localizedDescription
            self.showErrorAlert = true
        }
        
    }
    
    deinit{
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}
