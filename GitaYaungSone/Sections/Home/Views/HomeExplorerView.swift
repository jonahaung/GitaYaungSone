//
//  HomeExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 21/5/22.
//

import SwiftUI

struct HomeExplorerView: View {
    
    @StateObject private var viewModel = ExplorerViewModel()
    var body: some View {
        XSectionTitleView(title: "Suggestions") {
            XSectionView {
                VStack(spacing: 10) {
                    ForEach(viewModel.songs) { song in
                        ExplorerCell(song: song)
                        if song.id != viewModel.songs.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(5)
            }
        }
        .task {
            await viewModel.fetch(for: [])
        }
    }
}
