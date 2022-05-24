//
//  SongLineView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct SongLineView: View {
    let line: Song.Line
    var body: some View {
        HStack(spacing: 3) {
            ForEach(line.chordTexts) { chordText in
                VStack(alignment: .leading, spacing: 0) {
                    Text(chordText.chord)
                        .foregroundColor(.orange)
                        .tapToPresent(ChordDiagramView(chord: Chord.chord(for: chordText.chord)))
                    Spacer(minLength: 0)
                    Text(chordText.text)
                }
            }
        }
    }
}
