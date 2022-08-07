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
            Section(header: profilePhotoView()) {
                HStack {
                    Spacer()
                    XIcon(.heart_fill)
                        .foregroundColor(.pink)
                    Text(artist.popularity.description)
                        .italic()
                        .foregroundStyle(.secondary)
                }
            }

            Section("Albums") {
                ForEach(viewModel.allSongs.albums) { album in
                    DisclosureGroup {
                        ForEach(album.songs) {
                            SongListCell(song: $0)
                                .font(XFont.universal(for: .body).font)
                                .foregroundStyle(.secondary)
                        }
                    } label: {
                        Text(album.name.isWhitespace ? "No Album" : album.name)
                            .font(XFont.universal(for: .callout).font)
                    }
                }
            }
        }
        .navigationTitle(artist.name)
        .task {
            await viewModel.fetch(for: artist)
        }
    }

    private func profilePhotoView() -> some View {
        AsyncImage(url: URL(string: artist.photoURL ?? "https://media.kidadl.com/60222d821b08477d67613564_quotes_from_famous_infj_musicians_f8ad748170.jpeg"),
            content: { image in
                image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            }, placeholder: {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 250)
            })
    }
}
