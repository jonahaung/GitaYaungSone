//
//  ViewerLyricSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import SwiftUI

struct ViewerView: View {
    
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
                .font(Font.custom(XFont.MyanmarFont.MyanmarSansPro.rawValue, size: viewModel.fontSize))

                bottomBar()
            }
            .padding(.horizontal, 10)
        }
        .background(Color(uiColor: .secondarySystemBackground))

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingItems)
        .embeddedInNavigationView(showCancelButton: true)
        .task {
            await viewModel.task()
        }
    }

    private func bottomBar() -> some View {
        VStack {
            HStack(spacing: 10) {
                XIcon(.info_circle_fill)
                    .aspectRatio(1, contentMode: .fit)
                    .tapToPush(SongInfoView(song: viewModel.song))
                Text("PDF")
                    .tapToPresent(PdfView(attributedText: viewModel.song.attributedText(isDark: false))
                        .preferredColorScheme(.light))
                HasSavedButton(song: viewModel.song)
            }
            HStack {
                Slider(value: $viewModel.fontSize, in: 10.0...30.0)
            }
        }
        .padding()
    }

    private func floatingMenu() -> some View {
        Button {
            withAnimation{
                viewModel.showControls.toggle()
            }
        } label: {
            XIcon(viewModel.showControls ? .xmark : .music_note_list)
                .font(.title)
                .frame(width: 50, height: 50, alignment: .center)
        }.accentColor(.cyan)
    }
}

extension ViewerView {
    
    private var trailingItems: some View {
        HStack {
            Text(viewModel.song.artist)
                .foregroundStyle(.secondary)
                .tapToPush(ExplorerView(filters: [.artist(viewModel.song.artist)]))
            Text(viewModel.song.key)
        }

    }
    
}
