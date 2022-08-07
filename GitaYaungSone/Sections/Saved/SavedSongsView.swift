//
//  SavedSongsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI
import CoreData

struct SavedSongsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \YSong.popularity, ascending: true)],animation: .default)
    private var songs: FetchedResults<YSong>
    @AppStorage("SavedSongsView.Arrangement") private var currentArrangement = Arrangement.artist
    var allSong: AllSong { .init(Array(songs).map(Song.init))}
    
    var body: some View {
        Section {
            RemoteSearchableView {
                List {
                    Section {
                        switch currentArrangement {
                        case .artist:
                            arrangedByArtistsView()
                        case .album:
                            arrangedByAlbumsView()
                        case .song:
                            songsList(allSong.songs)
                        }
                    } header: {
                        segmentedControl()
                    } footer: {
                        Text("total \(allSong.allSongsCount) songs")
                    }
                }
                .font(XFont.universal(for: .body).font)
                .navigationTitle("Saved Items")
            }
        }
        .embeddedInNavigationView()
    }
    
    
    private func arrangedByAlbumsView() -> some View {
        Group {
            ForEach(allSong.albums) { album in
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
            ForEach(allSong.artists) { artist in
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
        Picker("Arrangement", selection: $currentArrangement) {
            ForEach(Arrangement.allCases, id: \.self) { arrangement in
                Text(arrangement.rawValue)
                    .tag(arrangement)
            }
        }
        .labelsHidden()
        .pickerStyle(.segmented)
    }
    
    private func songsList(_ songs: [Song]) -> some View {
        Group {
            ForEach(songs) {
                SongListCell(song: $0)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

extension SavedSongsView {
    enum Arrangement: String, CaseIterable {
        case artist, album, song
    }
}
