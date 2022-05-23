//
//  SongInfoView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import SwiftUI

struct SongInfoView: View {
    let song: Song
    
    var body: some View {
        List {
            Section {
                FormCell2 {
                    Text("Artist")
                } right: {
                    Text(song.artist)
                }
                FormCell2 {
                    Text("Album")
                } right: {
                    Text(song.album)
                }
                FormCell2 {
                    Text("Composer")
                } right: {
                    Text(song.composer)
                }
            }
            
            Section {
                FormCell2 {
                    Text("Key")
                } right: {
                    Text(song.key)
                }
                FormCell2 {
                    Text("Tempo")
                } right: {
                    Text(song.tempo)
                }
            }
            
            Section {
                FormCell2 {
                    Text("Genre")
                } right: {
                    Text(song.genre)
                }
                FormCell2 {
                    Text("Created")
                } right: {
                    Text(song.created, formatter: RelativeDateTimeFormatter())
                }
                FormCell2 {
                    Text("Link")
                } right: {
                    Text(song.mediaLink)
                }
            }
        }
        .navigationTitle("Info")
        .embeddedInNavigationView(showCancelButton: true)
    }
}
