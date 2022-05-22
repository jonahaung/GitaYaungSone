//
//  SavedSearchableView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import Foundation
import SwiftUI

struct SavedSearchableView<Content: View>: View {
    
    let content: () -> Content
    @StateObject private var viewModel = SavedSearchViewModel()
    
    var body: some View {
        content()
            .overlay(SavedSearchContentView().environmentObject(viewModel))
            .searchable(text: $viewModel.searchText, prompt: "Saved Songs")
    }
}
