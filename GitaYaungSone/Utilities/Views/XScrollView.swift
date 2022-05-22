//
//  XNavigationView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct XScrollView<Content: View>: View {
    let content: () -> Content
    var body: some View {
        ZStack {
            XConstants.UI.Colors.scrollVeiwBackground.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                content()
            }
            
        }
    }
}
