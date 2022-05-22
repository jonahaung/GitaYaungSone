//
//  SavedSearchContentView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct SavedSearchContentView: View {
    @EnvironmentObject private var viewModel: SavedSearchViewModel
    @Environment(\.isSearching) private var isSearching
    var body: some View {
        if isSearching {
            List {
                Section {
                    ForEach(viewModel.results) {
                        SearchResultCell(result: $0)
                    }
                }
            }
        }
    }
}
