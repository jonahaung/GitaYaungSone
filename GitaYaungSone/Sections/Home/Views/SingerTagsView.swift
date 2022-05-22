//
//  SingerTagsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
import WaterfallGrid

struct SingerTagsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            WaterfallGrid(Artist.demos) { artist in
                VStack {
                    Text(artist.name)
                        .font(.title3)
                        .foregroundColor(XColor.Light.random())
                }
                .padding(.init(top: 5, leading: 13, bottom: 5, trailing: 13))
                .background(Color(uiColor: .separator).cornerRadius(12))
                .tapToPush(ExplorerView(SearchItem(text: artist.name, property: .artist)))
            }
            .frame(minHeight: 250)
            .padding(.leading)
            .gridStyle(columns: 6, spacing: 3)
            .scrollOptions(direction: .horizontal)
        }
        
    }
}
