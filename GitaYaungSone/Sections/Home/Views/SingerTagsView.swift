//
//  SingerTagsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
import WaterfallGrid

struct SingerTagsView: View {
    
    @State private var artists = [Artist]()
    
    var body: some View {
        XSectionTitleView(title: "Artists/Bands") {
            ScrollView(.horizontal, showsIndicators: false) {
                WaterfallGrid(artists) { artist in
                    VStack {
                        Text(artist.name)
                            .font(.title3)
                            .foregroundColor(XColor.randomColor(seed: artist.name).color)
                    }
                    .padding(.init(top: 5, leading: 13, bottom: 5, trailing: 13))
                    .background(Color(uiColor: .opaqueSeparator).cornerRadius(12))
                    .tapToPush(ArtistView(artist: artist))
                }
                .gridStyle(columns: 6, spacing: 3)
                .frame(minHeight: 250)
                .padding(.leading)
                .scrollOptions(direction: .horizontal)
            }
        }
        .task {
            artists = await ArtistRepo.shared.fetch([])
        }
    }
}
