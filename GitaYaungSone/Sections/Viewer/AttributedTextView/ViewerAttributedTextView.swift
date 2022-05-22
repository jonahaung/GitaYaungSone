//
//  ViewerAttributedTextView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct ViewerAttributedTextView: View {
    
    @StateObject private var viewModel: ViewerViewModel
    
    init(song: Song) {
        _viewModel = .init(wrappedValue: .init(song))
    }
    
    var body: some View {
        ViewerTextView.SwiftUIView()
            .environmentObject(viewModel)
            .navigationBarTitleDisplayMode(.inline)
    }
}
