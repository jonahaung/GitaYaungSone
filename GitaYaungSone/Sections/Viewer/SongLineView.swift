//
//  SongLineView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct SongLineView: View {
    let item: Song.Line
    var body: some View {
        if item.hasNoChords {
            let text = item.chordTexts.map{ $0.text }.joined(separator: " ")
            Text(text)
                .foregroundStyle(.secondary)
        } else {
            AutoWrap(item.chordTexts, id: \.self, hSpacing: 3) {
                ChordTextView(item: $0)
            }
        }
    }
}
