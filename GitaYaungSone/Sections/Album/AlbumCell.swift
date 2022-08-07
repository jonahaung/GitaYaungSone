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
            XIcon(.music_note_list)
                .foregroundColor(XColor.UI.gray)
            Text(album.name)
                .lineLimit(1)
                .foregroundColor(.primary)
                .font(XFont.universal(for: .headline).font)
            Spacer()
            artistNameView()
        }
        .tapToPush(AlbumView(album: album))
    }

    private func artistNameView() -> some View {
        Group {
            if let artist = album.artist {
                Text(artist)
                    .font(XFont.universal(for: .footnote).font)
            }
        }
    }
}
