//
//  CordsLibraryView.swift
//  GuitarUkulele
//
//  Created by Aung Ko Min on 15/3/22.
//

import SwiftUI

struct ChordsLibrarySession: View {
    
    @State private var selectedInstrument: Instrument = .guitar
    @State private var selectedKey: String = "C"
    @State private var selectedSuffix: String = "major"
    
    private let instruments = [Instrument.guitar, Instrument.ukulele]
    private var foundChords: [LibraryChord.Position] {
        selectedInstrument.findChordPositions(key: selectedKey, suffix: selectedSuffix)
    }
    
    var body: some View {
        XScrollView {
            Group {
                XSectionView {
                    HStack {
                        Spacer()
                        Picker("Instrument", selection: $selectedInstrument) {
                            ForEach(instruments, id: \.self) {
                                Text($0.name.capitalized(with: nil))
                            }
                        }
                        Spacer()
                        Picker("Key", selection: $selectedKey) {
                            ForEach(selectedInstrument.keys, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        Picker("Suffix", selection: $selectedSuffix) {
                            ForEach(selectedInstrument.suffixes, id: \.self) {
                                Text($0)
                            }
                        }
                        Spacer()
                    }
                }
                
                LazyVGrid(columns: [.init(), .init()]) {
                    ForEach(foundChords, id: \.self) { position in
                        FretboardView(position: position)
                            .aspectRatio(0.6, contentMode: .fit)
                            
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Chords Library")
        .embeddedInNavigationView()
    }
}
