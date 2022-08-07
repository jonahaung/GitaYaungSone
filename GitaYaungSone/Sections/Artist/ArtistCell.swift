//
//  ArtistCell.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import SwiftUI

struct ArtistCell: View {
    let artist: Artist
    var body: some View {
        HStack {
            XIcon(.music_mic)
                .foregroundColor(XColor.UI.blue)
            Text(artist.name)
                .foregroundColor(.primary)
            Spacer()
            Text(artist.popularity.description)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .tapToPush(ArtistView(artist: artist))
    }
}
