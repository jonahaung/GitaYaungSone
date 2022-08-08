//
//  ViewerLyricSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import SwiftUI

struct ViewerView: View {

    init(song: Song) {
        _viewModel = .init(wrappedValue: .init(song))
    }

    @StateObject private var viewModel: ViewerViewModel

    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: false) {
            VStack(alignment: .leading, spacing: 3) {
                Section {
                    Text(viewModel.song.title)
                        .font(XFont.title(for: viewModel.song.title).font)
                    ForEach(viewModel.song.lines()) {
                        SongLineView(line: $0)
                    }
                    Spacer(minLength: 100)
                }
                .font(Font.custom(XFont.MyanmarFont.MyanmarSansPro.rawValue, size: viewModel.fontSize))
            }
            .padding(.horizontal, 10)
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .overlay(bottomBar(), alignment: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingItems)
        .embeddedInNavigationView(showCancelButton: true)
        .task {
            await viewModel.task()
        }
    }
}

extension ViewerView {

    private func bottomBar() -> some View {
        HStack(spacing: 10) {
            HasSavedButton(song: viewModel.song)
            Text("PDF")
                .tapToPresent(PdfView(attributedText: viewModel.song.attributedText(isDark: false))
                    .preferredColorScheme(.light))
            Slider(value: $viewModel.fontSize, in: 8.0...25.0)
            XIcon(.info_circle_fill)
                .aspectRatio(1, contentMode: .fit)
                .tapToPush(SongInfoView().environmentObject(viewModel))
        }
        .padding(.horizontal)
        .background(.ultraThinMaterial)
    }

    private var trailingItems: some View {
        HStack {
            if let artist = viewModel.artist {
                Text(artist.name)
                    .foregroundStyle(.secondary)
                    .tapToPush(ArtistView(artist: artist))
            }
            Spacer()
            HStack {
                Text("Key ")
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(viewModel.song.key)
            }
        }
    }
}
