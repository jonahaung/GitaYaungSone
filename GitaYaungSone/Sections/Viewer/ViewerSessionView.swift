//
//  ViewerLyricSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import SwiftUI

struct ViewerSessionView: View {
    
    @StateObject private var viewModel: ViewerViewModel
    
    init(song: Song) {
        _viewModel = .init(wrappedValue: .init(song))
    }
    
    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: false) {
            VStack(alignment: .leading, spacing: 3) {
                Section {
                    Text(viewModel.song.title.whiteSpace)
                        .font(XFont.title(for: viewModel.song.title).font)
                }
                
                Section {
                    ForEach(viewModel.song.lines()) {
                        SongLineView(line: $0)
                    }
                }
                .font(XFont.universal(for: .subheadline).font)
                
                Divider()
                    .padding()
                
                bottomBar()
            }
        }
        .padding(.horizontal, 10)
        .background(Color(uiColor: .secondarySystemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingItems)
        .embeddedInNavigationView(showCancelButton: true)
        .task {
            await viewModel.task()
        }
    }

    private func bottomBar() -> some View {
        HStack(spacing: 10) {
            XIcon(.info_circle_fill)
                .aspectRatio(1, contentMode: .fit)
                .tapToPush(SongInfoView(song: viewModel.song))
            Text("PDF")
                .tapToPresent(PdfView(attributedText: viewModel.song.attributedText(isDark: false))
                    .preferredColorScheme(.light))
            HasSavedButton(song: viewModel.song)
        }
    }
}

extension ViewerSessionView {
    
    private var trailingItems: some View {
        HStack {
            Text(viewModel.song.artist)
                .foregroundStyle(.secondary)
                .tapToPush(ExplorerView(filters: [.artist(viewModel.song.artist)]))
            Text(viewModel.song.key)
        }

    }
    
}
