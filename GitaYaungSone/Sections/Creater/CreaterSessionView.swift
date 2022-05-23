//
//  CreaterSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct CreaterSessionView: View {
    
    @StateObject private var viewModel = CreaterViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showForm = false
    
    var body: some View {
        NavigationView {
            CreaterTextView.SwiftUIView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: leadingItems, trailing: trailingItems)
                .toolbar(content: toolBar)
                .importable()
                .fullScreenCover(isPresented: $showForm) {
                    CreaterForm()
                }
                .environmentObject(viewModel)
                .navigationViewStyle(.stack)
                .authenticatable()
        }
        .customThemeStyle()
    }
}

// Nav Items
extension CreaterSessionView {
    private var leadingItems: some View {
        let cancelButtonIsProtected = !viewModel.song.title.isWhitespace || !viewModel.song.artist.isWhitespace || !viewModel.song.rawText.isWhitespace
        return CancelButton(dismiss: _dismiss, isProtected: cancelButtonIsProtected)
    }
    
    private var trailingItems: some View {
        let saveButtonEnabled = !viewModel.song.title.isWhitespace && !viewModel.song.artist.isWhitespace && !viewModel.song.rawText.isWhitespace
        return HStack {
            ComfirmButton(buttonText: "Upload this song") {
                SongRepo.shared.add(viewModel.song) { error in
                    DispatchQueue.main.async {
                        YSong.create(song: viewModel.song)
                        self.dismiss()
                    }
                }
            } label: {
                Text("Save")
            }
            .disabled(!saveButtonEnabled)
        }
    }
}

// Toolbar
extension CreaterSessionView {
    
    private func toolBar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            ComfirmButton(buttonText: "Clear Everyting", action: onClear) {
                Text("Clear")
            }
            .disabled(viewModel.song.rawText.isWhitespace)
            
            Spacer()
            Text("Preview")
                .tapToPresent(ViewerSessionView(song: viewModel.song).embeddedInNavigationView())
                .disabled(!viewModel.song.canSave)
            
            Spacer()
            XIcon(.music_note_list)
                .tapToPresent(CreaterForm(), .fullScreen)
        }
    }
    private func onClear() {
        viewModel.song = .init()
    }
}
