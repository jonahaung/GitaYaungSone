//
//  SongListCell.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct SongListCell: View {
    
    let song: Song
    
    var body: some View {
        HStack {
            XIcon(.music_note)
                .foregroundColor(.brown)
            Text(song.title)
                .foregroundColor(.secondary)
            Spacer()
        }
        .font(XFont.universal(for: .body).font)
        .tapToPresent(ViewerView(song: song), .fullScreen)
    }
}
