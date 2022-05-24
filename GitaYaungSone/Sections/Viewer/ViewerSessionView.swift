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
                    +
                    Text(viewModel.song.artist.nonLineBreak)
                        .font(XFont.footnote(for: viewModel.song.artist).font)
                }
                .foregroundColor(.orange)
                
                Section {
                    ForEach(viewModel.song.lines()) {
                        SongLineView(line: $0)
                    }
                }
                .font(XFont.body(for: viewModel.song.rawText).font)
                
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
        HStack {
            XIcon(.square_and_arrow_up)
            XIcon(.heart_fill).foregroundColor(.pink)
            Text("PDF").tapToPresent(PdfView(attributedText: viewModel.song.attributedText()))
            Text("Text").tapToPresent(ViewerAttributedTextView(song: viewModel.song))
        }
    }
}

extension ViewerSessionView {
    
    private var trailingItems: some View {
        XIcon(.info)
            .aspectRatio(1, contentMode: .fit)
            .tapToPresent(SongInfoView(song: viewModel.song))
    }
}
