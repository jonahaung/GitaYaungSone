//
//  HomeExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 21/5/22.
//

import SwiftUI

struct PopularSongsView: View {
    
    @StateObject private var viewModel = ExplorerViewModel()
    
    var body: some View {
        XSectionTitleView(title: "Suggestions") {
            XSectionView {
                VStack(spacing: 10) {
                    ForEach(viewModel.displayingSong) { song in
                        ExplorerCell(song: song)
                        if song.id != viewModel.displayingSong.last?.id {
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
