//
//  SavedSearchViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import Foundation
import SwiftUI
import Combine
final class SavedSearchViewModel: ObservableObject {
    
    @Published var results = [SearchItem]()
    @Published var searchText = String()
    
    private var subscription: Set<AnyCancellable> = []
    init() {
        $searchText
            .sink(receiveValue: { [weak self] text in
                self?.searchItems(string: text)
            })
            .store(in: &subscription)
    }
    
    private func searchItems(string: String) {
        var results = [SearchItem]()
        YSong.search(text: string).map(Song.init).forEach { song in
            if song.title.contains(string) {
                let item = SearchItem(text: song.title, property: .title)
                results.append(item)
            }
            if song.artist.contains(string) {
                let item = SearchItem(text: song.artist, property: .artist)
                results.append(item)
            }
            if song.composer.contains(string) {
                let item = SearchItem(text: song.composer, property: .composer)
                results.append(item)
            }
            if song.album.contains(string) {
                let item = SearchItem(text: song.album, property: .album)
                results.append(item)
            }
        }
        self.results = results
    }
}
