//
//  AlbumCell.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import SwiftUI

struct AlbumCell: View {

    let album: Album

    var body: some View {
        HStack {
            XIcon(.music_quarternote_3)
                .foregroundColor(XColor.UI.gray)
            Text(album.name)
                .foregroundColor(.primary)
                .font(XFont.universal(for: .body).font)
            Spacer()
            artistNameView()
        }
        .tapToPush(AlbumView(album: album))
    }

    private func artistNameView() -> some View {
        Group {
            if let artist = album.artist {
                Text(artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
