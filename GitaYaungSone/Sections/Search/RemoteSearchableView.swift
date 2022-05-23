//
//  SearchableView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI
struct RemoteSearchableView<Content: View>: View {
    let content: () -> Content
    @StateObject private var viewModel = RemoteSearchViewModel()
    
    var body: some View {
        content()
            .overlay(RemoteSearchContentView().environmentObject(viewModel))
            .searchable(text: $viewModel.searchText, prompt: "Search songs, artists")
    }
}
