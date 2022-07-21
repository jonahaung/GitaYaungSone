//
//  HasSavedButton.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 22/7/22.
//

import SwiftUI

struct HasSavedButton: View {
    @State var song: Song
    @State private var ySong: YSong?
    private var hasSaved: Bool { ySong != nil }
    
    var body: some View {
        Button(action: {
            if let saved = YSong.hasSaved(for: song.id ?? "") {
                YSong.delete(ySong: saved)
            } else {
                _ = YSong.save(song: song)
            }
            checkIfSaved()
        }, label: {
            XIcon(hasSaved ? .heart_fill: .heart).foregroundColor(hasSaved ? .pink: .white)
            
        })
        .task {
            checkIfSaved()
        }
    }
    
    private func checkIfSaved() {
        ySong = YSong.hasSaved(for: song.id ?? "")
    }
}
