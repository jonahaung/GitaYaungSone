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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Section {
                    Text(viewModel.song.title.whiteSpace)
                        .font(XFont.title(for: viewModel.song.title).font)
                    +
                    Text(viewModel.song.artist.nonLineBreak)
                        .font(XFont.footnote(for: viewModel.song.artist).font)
                }
                Section {
                    ForEach(viewModel.song.lines()) {
                        SongLineView(item: $0)
                    }
                }
                .font(XFont.body(for: viewModel.song.rawText).font)
            }
        }
        .padding(.horizontal, 8)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingItems)
        .embeddedInNavigationView(showCancelButton: true)
    }
}

extension ViewerSessionView {
    
    private var trailingItems: some View {
        HStack {
            Text("PDF")
                .tapToPresent(PdfView(attributedText: viewModel.song.attributedText()))
            
            Text("Text")
                .tapToPresent(ViewerAttributedTextView(song: viewModel.song))
        }
    }
}
