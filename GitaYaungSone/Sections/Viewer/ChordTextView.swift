//
//  ChordTextView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct ChordTextView: View {
    
    let item: Song.Line.ChordText
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ChordTag(chord: item.chord)
            Spacer(minLength: 0)
            Text(item.text)
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct ChordTag: View {
    let chord: String
    var body: some View {
        Text(chord)
//            .font(XFont.chord().font)
            .foregroundColor(.orange)
            .tapToPresent(Text(chord))
    }
}
