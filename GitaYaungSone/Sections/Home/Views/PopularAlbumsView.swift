//
//  AlbumTagsView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 22/7/22.
//

import SwiftUI
import WaterfallGrid

struct PopularAlbumsView: View {

    @State private var albums = [Album]()

    var body: some View {
        XSectionTitleView(title: "Albums") {
            XSectionView {
                VStack(spacing: 10) {
                    ForEach(albums) { album in
                        HStack {
                            XIcon(.book_fill)
                            Text(album.name)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(album.popularity.description)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .tapToPush(ExplorerView(filters: [.album(album.name)]))
                        if album.id != albums.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(5)
            }
        }
        .task {
            albums = await AlbumRepo.shared.fetch([])
        }
    }
}

