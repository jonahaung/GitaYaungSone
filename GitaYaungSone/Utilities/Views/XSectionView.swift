//
//  XSection.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct XSectionView<Content: View>: View {
    let content: () -> Content
    var body: some View {
        VStack(spacing: 0) {
            content()
                .padding(7)
        }
        .background(
            XConstants.UI.Colors.sectionBackground
                .cornerRadius(
                    XConstants.UI.XSection.coornorRadius))
        .padding(7)
    }
}

