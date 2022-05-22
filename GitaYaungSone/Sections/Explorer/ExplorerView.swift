//
//  ExplorerView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct ExplorerView: View {
    
    @StateObject private var viewModel: ExplorerViewModel
    
    init(_ filter: SearchItem?) {
        _viewModel = .init(wrappedValue: .init(filter))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                ExplorerCell(song: song)
            }
        }
        .task {
            await viewModel.fetch()
        }
        .navigationTitle(viewModel.filter?.text ?? "My Song Book")
    }
}
