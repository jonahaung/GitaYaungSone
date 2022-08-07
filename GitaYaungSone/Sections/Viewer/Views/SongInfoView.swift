//
//  SongInfoView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import SwiftUI

struct SongInfoView: View {

    let song: Song
    @State private var artist: Artist?
    @State private var album: Album?

    var body: some View {
        List {
            Section(song.title) {
                if let artist = self.artist {
                    FormCell2 {
                        Text("Artist")
                    } right: {
                        Text(song.artist)
                    }
                    .tapToPush(ArtistView(artist: artist))
                }
                
                if let album = album {
                    FormCell2 {
                        Text("Album")
                    } right: {
                        Text(song.album)
                    }
                    .tapToPush(AlbumView(album: album))
                }

                FormCell2 {
                    Text("Composer")
                } right: {
                    Text(song.composer)
                }
                .tapToPush(ExplorerView(filters: [.composer(song.composer)]))
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
                .tapToPush(ExplorerView(filters: [.genre(song.genre)]))
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
                FormCell2 {
                    Text("Views")
                } right: {
                    Text(song.popularity.description)
                }
            }
        }
        .navigationTitle("Info")
//        .embeddedInNavigationView(showCancelButton: true)
        .task {
            artist = await ArtistRepo.shared.fetch([.name(song.artist)]).first
            album = await AlbumRepo.shared.fetch([.name(song.album)]).first
        }
    }
}
