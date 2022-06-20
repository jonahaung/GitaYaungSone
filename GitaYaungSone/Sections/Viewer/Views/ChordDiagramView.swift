//
//  ChordDiagramView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 25/5/22.
//

import SwiftUI

struct ChordDiagramView: View {
    
    let chord: Chord?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                if let chord = chord, let positions = Instrument.guitar.findChordPositions(key: chord.key.rawValue, suffix: chord.suffix.rawValue) {
                    ForEach(positions) {
                        FretboardView(position: $0)
                            .aspectRatio(0.6, contentMode: .fit)
                    }
                } else {
                    Text("Chord Format Error")
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(chord?.name ?? "")
        .embeddedInNavigationView(showCancelButton: true)
    }
}

extension Chord {
    
    static func chord(for chordString: String) -> Chord? {
        
        guard let match = RegularExpression.chordPatternBeginning.firstMatch(in: chordString, options: [], range: chordString.nsRange()) else {
            return nil
        }
        
        guard let keyRange = Range(match.range(at: 1), in: chordString) else {
            return nil
        }
        
        var valueKey = chordString[keyRange]
        if valueKey == "G#" {
            valueKey = "Ab"
        }
        if valueKey == "Gb" {
            valueKey = "F#"
        }
        if valueKey == "Db" {
            valueKey = "C#"
        }
        guard let key = Chord.Key(rawValue: String(valueKey)) else {
            return nil
        }
        
        var suffix: Chord.Suffix = .major
        
        if let valueRange = Range(match.range(at: 2), in: chordString) {
            var suffixString = "major"
            switch chordString[valueRange] {
            case "m":
                suffixString = "minor"
            default:
                suffixString = String(chordString[valueRange])
            }
            suffix = Chord.Suffix(rawValue: suffixString) ?? .major
        }
        
        return Chord(key: key, suffix: suffix)
    }
}
