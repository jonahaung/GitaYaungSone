//
//  ArtistView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import SwiftUI

struct ArtistView: View {

    let artist: Artist
    @StateObject private var viewModel = ArtistViewModel()

    var body: some View {
        List {
            if viewModel.searchText.isEmpty {
                Section(header: profilePhotoView()) {
                    HStack {
                        XIcon(.heart_fill)
                            .foregroundColor(.pink)
                        Spacer()
                        XIcon(.star_fill)
                        Text(artist.popularity.description)
                            .italic()
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section("Albums") {
                ForEach(viewModel.allSongs.albums) { album in
                    DisclosureGroup {
                        ForEach(album.songs) {
                            SongListCell(song: $0)
                                .foregroundStyle(.secondary)
                        }
                    } label: {
                        Text(album.name.isWhitespace ? "No Album" : album.name)
                            .font(XFont.universal(for: .callout).font)
                    }
                }
            }

            Section("Songs") {
                ForEach(viewModel.songs) { song in
                    SongListCell(song: song)
                }
            }

        }
        .navigationTitle(artist.name)
        .searchable(text: $viewModel.searchText, prompt: "Search \(artist.name)'s songs")
        .task {
            await viewModel.fetch(for: artist)
        }
    }

    private func profilePhotoView() -> some View {
        VStack {
            let url = URL(string: artist.photoURL ?? "https://media.kidadl.com/60222d821b08477d67613564_quotes_from_famous_infj_musicians_f8ad748170.jpeg")
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
            } placeholder: {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 250)
            }
        }
    }
}
