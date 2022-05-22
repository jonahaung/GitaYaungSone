//
//  Authenticator.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation

class Authenticator: ObservableObject {
    
    static let shared = Authenticator()
    @Published var isUnAuthenticated = false
}
