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
        Group {
            switch line.lineType {
            case .Directive:
                if let comment = line.comment {
                    Text(comment)
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.secondary)
                }
            case .Chords:
                HStack(spacing: 5) {
                    ForEach(line.chordTexts) { chordText in
                        if let chord = chordText.chord {
                            ChordView(chord: chord)
                        }
                    }
                }
            case .Texts:
                Text(line.chordTexts.map{$0.text}.joined(separator: " "))
            case .Lyric:
                HStack(spacing: 3) {
                    ForEach(line.chordTexts) { chordText in
                        VStack(alignment: .leading, spacing: 0) {
                            if let chord = chordText.chord {
                                ChordView(chord: chord)
                            }
                            Spacer(minLength: 0)
                            Text(chordText.text)
                        }
                    }
                }
            case .Empty:
                Spacer(minLength: 5)
            }
        }
    }
}

struct ChordView: View {
    let chord: Chord
    var body: some View {
        Text(chord.name)
            .foregroundColor(.orange)
            .tapToPresent(ChordDiagramView(chord: chord))
    }
}
