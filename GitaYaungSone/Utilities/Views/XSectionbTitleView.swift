//
//  XSectionbTitleView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import SwiftUI

struct XSectionTitleView<Content: View>: View {
    let title: String
    let content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(.tertiary)
                .padding(.horizontal)
            content()
        }
    }
}
