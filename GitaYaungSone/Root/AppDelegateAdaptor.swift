//
//  AppDelegateAdaptor.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI
import FirebaseCore

class AppDelegateAdaptor: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemBrown, .font: UIFont.preferredFont(forTextStyle: .title1)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemBrown]
        return true
    }
}
