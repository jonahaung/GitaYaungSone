//
//  SearchViewModel.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 22/3/22.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class RemoteSearchViewModel: ObservableObject {
    
    @Published var songs = [SearchItem]()
    @Published var artists = [SearchItem]()
    
    @Published var searchText = String()
    
    private var subscription: Set<AnyCancellable> = []
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .filter{ !$0.isWhitespace }
            .sink { [weak self] text in
                self?.searchItems(text)
            }
            .store(in: &subscription)
    }
    
    private func searchItems(_ string: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let songsQuery = Firestore.firestore().collection("songs")
                .whereField("title", isGreaterThanOrEqualTo: string)
                .whereField("title", isLessThan: string + "\u{f8ff}")
                .order(by: "title")
                .limit(to: 8)
            let songs: [Song] = await APIService.shared.GET(query: songsQuery)
            
            let artistsQuery = Firestore.firestore().collection("artists")
                .whereField("name", isGreaterThanOrEqualTo: string)
                .whereField("name", isLessThan: string + "\u{f8ff}")
                .order(by: "name")
            let artists: [Artist] = await APIService.shared.GET(query: artistsQuery)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.songs = songs.map{.init(text: $0.title, property: .title)}
                self.artists = artists.map{.init(text: $0.name, property: .artist)}
            }
        }
    }
}
