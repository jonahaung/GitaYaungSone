//
//  SearchViewModel.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 22/3/22.
//

import SwiftUI
import Combine

final class RemoteSearchViewModel: ObservableObject {
    
    @Published var songs = [Song.QueryFilter]()
    @Published var artists = [Song.QueryFilter]()
    
    @Published var searchText = String()
    
    private var subscription: Set<AnyCancellable> = []
    init() {
        $searchText
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
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
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.songs = songs.map{.title($0.title)}
                self.artists = artists.map{.artist($0.name)}
            }
        }
    }
}
