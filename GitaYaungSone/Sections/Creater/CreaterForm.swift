//
//  CreaterForm.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct CreaterForm: View {
    
    @EnvironmentObject private var viewModel: CreaterViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("* Required Fields") {
                FormCell(icon: .doc_append) {
                    TextField("Song Title", text: $viewModel.song.title)
                }
                FormCell(icon: .music_mic) {
                    Group {
                        TextField("Artist / Singer", text: $viewModel.song.artist)
                        XIcon(.magnifyingglass)
                            .imageScale(.medium)
                            .tapToPresent(XPicker(title: "Artists", items: Artist.demos.map{$0.name}, pickedItem: $viewModel.song.artist), .fullScreen)
                    }
                }
            }
            
            Section("Instrument") {
                FormCell(icon: .tuningfork) {
                    Picker("Key", selection: $viewModel.song.key) {
                        ForEach(Chord.Key.allCases) {
                            Text($0.rawValue)
                                .tag($0.rawValue)
                        }
                    }
                    
                }
                FormCell(icon: .metronome) {
                    TextField.init("Tempo", text: $viewModel.song.tempo)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            
            Section("Additional Informations") {
                FormCell(icon: .highlighter) {
                    TextField.init("Composer", text: $viewModel.song.composer)
                    
                }
                FormCell(icon: .magazine) {
                    TextField.init("Album", text: $viewModel.song.album)
                }
                FormCell(icon: .calendar) {
                    TextField.init("Year", text: $viewModel.song.year)
                        .keyboardType(.numbersAndPunctuation)
                }
                FormCell(icon: .music_note_tv) {
                    Picker("Genre", selection: $viewModel.song.genre) {
                        ForEach(Genre.allCases) {
                            Text($0.rawValue)
                                .tag($0.rawValue)
                        }
                    }
                }
                FormCell(icon: .link) {
                    TextField.init("Media Link", text: $viewModel.song.mediaLink)
                        .keyboardType(.URL)
                }
            }
            Section("Import") {
                Button("Hotel California") {
                    viewModel.song = Song.hotelCalifornia
                }
                Button("Myanmar") {
                    viewModel.song = Song.myanmar
                }
            }
        }
        .autocapitalization(.words)
        .navigationBarItems(leading: leadingItems, trailing: trailingItems)
        .embeddedInNavigationView(showCancelButton: true)
    }
}

extension CreaterForm {
    private var trailingItems: some View {
        HStack {
            Button("Done") {
                dismiss()
            }.disabled(viewModel.song.hasNotFilledForm)
        }
    }
    private var leadingItems: some View {
        HStack {
            
        }
    }
}
