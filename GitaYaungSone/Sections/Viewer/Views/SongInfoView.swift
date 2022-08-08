//
//  SongInfoView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import SwiftUI

struct SongInfoView: View {

    @EnvironmentObject var viewModel: ViewerViewModel

    var body: some View {
        List {
            Section(viewModel.song.title) {
                if let artist = viewModel.artist {
                    FormCell2 {
                        Text("Artist")
                    } right: {
                        Text(artist.name)
                    }
                    .tapToPush(ArtistView(artist: artist))
                }
                
                if let album = viewModel.album {
                    FormCell2 {
                        Text("Album")
                    } right: {
                        Text(album.name)
                    }
                    .tapToPush(AlbumView(album: album))
                }

                FormCell2 {
                    Text("Composer")
                } right: {
                    Text(viewModel.song.composer)
                }
                .tapToPush(ExplorerView(filters: [.composer(viewModel.song.composer)]))
            }
            
            Section {
                FormCell2 {
                    Text("Key")
                } right: {
                    Text(viewModel.song.key)
                }
                FormCell2 {
                    Text("Tempo")
                } right: {
                    Text(viewModel.song.tempo)
                }
            }
            
            Section {
                FormCell2 {
                    Text("Genre")
                } right: {
                    Text(viewModel.song.genre)
                }
                .tapToPush(ExplorerView(filters: [.genre(viewModel.song.genre)]))
                FormCell2 {
                    Text("Created")
                } right: {
                    Text(viewModel.song.created, formatter: RelativeDateTimeFormatter())
                }
                FormCell2 {
                    Text("Link")
                } right: {
                    Text(viewModel.song.mediaLink)
                }
                FormCell2 {
                    Text("Views")
                } right: {
                    Text(viewModel.song.popularity.description)
                }
            }
        }
        .navigationTitle("Info")
    }
}
