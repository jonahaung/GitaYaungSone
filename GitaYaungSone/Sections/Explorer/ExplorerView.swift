//
//  ExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct ExplorerView: View {
    
    let filters: [Song.QueryFilter]
    
    @StateObject private var viewModel = ExplorerViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                ExplorerCell(song: song)
            }
        }
        .task {
            await viewModel.fetch(for: filters)
        }
        .navigationTitle(filters.map{$0.value}.joined(separator: " "))
    }
}
