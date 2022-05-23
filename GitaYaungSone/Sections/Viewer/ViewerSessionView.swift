//
//  ViewerLyricSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import SwiftUI

struct ViewerSessionView: View {
    
    @StateObject private var viewModel: ViewerViewModel
    @State private var showFullScreen = false
    
    init(song: Song) {
        _viewModel = .init(wrappedValue: .init(song))
    }
    
    var body: some View {
        XScrollView {
            Group {
                LazyVStack(alignment: .leading, spacing: 0) {
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
                
                Divider()
                    .padding()
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        XIcon(.square_and_arrow_up)
                        XIcon(.heart_fill)
                            .foregroundColor(.pink)
                        Text("PDF")
                            .tapToPresent(PdfView(attributedText: viewModel.song.attributedText()))
                        
                        Text("Text")
                            .tapToPresent(ViewerAttributedTextView(song: viewModel.song))
                    }
                }
                .padding(.bottom)
            }
        }
        .padding(.horizontal, 8)
        .background(Color(uiColor: .secondarySystemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingItems)
        .navigationBarHidden(showFullScreen)
        .embeddedInNavigationView(showCancelButton: true)
        .task {
            await viewModel.task()
        }
    }
}

extension ViewerSessionView {
    
    private var trailingItems: some View {
        XIcon(.info)
            .padding()
            .tapToPresent(SongInfoView(song: viewModel.song))
    }
}
