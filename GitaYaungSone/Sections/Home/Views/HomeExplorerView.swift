//
//  HomeExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 21/5/22.
//

import SwiftUI

struct HomeExplorerView: View {
    
    @StateObject private var viewModel = ExplorerViewModel(nil)
    var body: some View {
        LazyVStack(spacing: 10) {
            ForEach(viewModel.songs) { song in
                ExplorerCell(song: song)
            }
        }
        .padding(5)
        .task {
            await viewModel.fetch()
        }
    }
}
