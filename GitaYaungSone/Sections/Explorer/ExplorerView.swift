//
//  ExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct ExplorerView: View {
    
    let filters: [Song.QueryFilter]

    @StateObject private var viewModel = ExplorerViewModel()
    @State private var currentArrangement = Arrangement.song
    
    var body: some View {
        List {
            Section {
                switch currentArrangement {
                case .artist:
                    arrangedByArtistsView()
                case .album:
                    arrangedByAlbumsView()
                case .song:
                    songsList(viewModel.allSongs.songs)
                }
            } header: {
                segmentedControl()
            } footer: {
                sectionFooterView()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "\(filters.first?.value ?? "Search")")
        .navigationTitle(filters.map{$0.key}.joined(separator: " "))
        .task {
            await viewModel.fetch(for: filters)
        }
    }
    
    private func arrangedByAlbumsView() -> some View {
        Group {
            ForEach(viewModel.allSongs.albums) { album in
                DisclosureGroup {
                    songsList(album.songs)
                } label: {
                    Text(album.name.isWhitespace ? "No Album" : album.name)
                }
            }
        }
    }

    private func arrangedByArtistsView() -> some View {
        Group {
            ForEach(viewModel.allSongs.artists) { artist in
                DisclosureGroup {
                    ForEach(artist.albums) { album in
                        if album.name.isWhitespace {
                            songsList(album.songs)
                        }else {
                            DisclosureGroup {
                                songsList(album.songs)
                            } label: {
                                Text(album.name)
                            }
                        }
                    }
                } label: {
                    Text(artist.name)
                }
            }
        }
    }
    private func segmentedControl() -> some View {
        VStack {
            Picker("Arrangement", selection: $currentArrangement) {
                ForEach(Arrangement.allCases, id: \.self) { arrangement in
                    Text(arrangement.rawValue)
                        .tag(arrangement)
                }
            }
            .labelsHidden()
            .pickerStyle(.segmented)
        }
    }

    private func songsList(_ songs: [Song]) -> some View {
        ForEach(songs) {
            ExplorerCell(song: $0)
        }
    }
    private func sectionFooterView() -> some View {
        Text("\(viewModel.displayingSong.count) items")
    }


    enum Arrangement: String, CaseIterable {
        case artist, album, song
    }
}
