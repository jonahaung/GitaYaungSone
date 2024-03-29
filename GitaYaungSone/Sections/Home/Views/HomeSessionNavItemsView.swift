//
//  HomeSessionNavItemsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct HomeSessionNavItemsView<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        content()
            .navigationTitle("Home")
            .navigationBarItems(leading: AppLogoView(fontSize: 24))
    }
}
