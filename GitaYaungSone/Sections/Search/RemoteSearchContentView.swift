//
//  SearchContentView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct RemoteSearchContentView: View {
    
    @EnvironmentObject private var viewModel: RemoteSearchViewModel
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        if isSearching {
            List {
                if !viewModel.artists.isEmpty {
                    Section("Artists") {
                        ForEach(viewModel.artists) {
                            ArtistCell(artist: $0)

                        }
                    }
                }
                if !viewModel.albums.isEmpty {
                    Section("Albums") {
                        ForEach(viewModel.albums) {
                            AlbumCell(album: $0)
                        }
                    }
                }
                if !viewModel.songs.isEmpty {
                    Section("Songs") {
                        ForEach(viewModel.songs) {
                            ExplorerCell(song: $0)
                        }
                    }
                }
            }
        }
    }
}
