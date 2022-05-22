//
//  IconTagsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
import WaterfallGrid

struct IconTagsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            WaterfallGrid(XIcon.Icon.allCases, id: \.self) { icon in
                Image(systemName: icon.systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(3)
                    .foregroundColor(XColor.UI.random())
            }
            .frame(height: 250)
            .gridStyle(columns: 5, animation: .interactiveSpring())
            .scrollOptions(direction: .horizontal)
            .padding(5)
        }
    }
}
