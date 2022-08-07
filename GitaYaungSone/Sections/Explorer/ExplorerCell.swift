//
//  LyricsTableViewCell.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 22/3/22.
//

import SwiftUI

struct ExplorerCell: View {
    
    let song: Song
    
    var body: some View {
        HStack {
            XIcon(.music_note)
            
            Text(song.title.whiteSpace)
                .font(XFont.headline(for: song.title).font)
                .foregroundColor(.secondary)
            +
            Text(" ")
            +
            Text(song.artist)
                .font(XFont.universal(for: .footnote).font)
            Spacer()

        }
        .tapToPresent(ViewerSessionView(song: song), .fullScreen)
    }
}
