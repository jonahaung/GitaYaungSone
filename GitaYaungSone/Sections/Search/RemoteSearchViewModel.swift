//
//  SearchViewModel.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 22/3/22.
//

import SwiftUI
import Combine

final class RemoteSearchViewModel: ObservableObject {

    var songs = [Song]()
    var artists = [Artist]()
    var albums = [Album]()
    
    @Published var searchText = String()
    
    private var subscription: Set<AnyCancellable> = []
    init() {
        $searchText
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .filter{ !$0.isWhitespace }
            .sink { [weak self] text in
                self?.searchItems(text)
            }
            .store(in: &subscription)
    }
    
    private func searchItems(_ string: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let songs = await SongRepo.shared.search([.title(string)], limit: 8)
            let artists = await ArtistRepo.shared.search([.name(string)], limit: 10)
            let albums = await AlbumRepo.shared.search([.name(string)], limit: 10)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.artists = artists
                self.albums = albums
                self.songs = songs
                self.objectWillChange.send()
            }
        }
    }
}
