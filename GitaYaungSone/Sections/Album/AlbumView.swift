//
//  AlbumView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import SwiftUI

struct AlbumView: View {

    let album: Album
    @StateObject private var viewModel = AlbumViewModel()

    var body: some View {
        List {
            Section(header: headerView(), footer: footerView()) {
                ForEach(viewModel.displayingSong) { song in
                    SongListCell(song: song)
                }
            }
        }
        .navigationTitle(album.name)
        .task {
            await viewModel.fetch(for: album)
        }
    }

    private func headerView() -> some View {
        HStack {
            Text(album.artist ?? "")

            Spacer()
            Text(album.popularity.description)
                .italic()
                .foregroundStyle(.secondary)
        }
    }

    private func footerView() -> some View {
        Text("\(viewModel.displayingSong.count) songs")
    }
}
