//
//  ExplorerViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import Foundation

final class ExplorerViewModel: ObservableObject {
    
    private var songs = [Song]()
    var displayingSong: [Song] { searchText.isEmpty ? songs : songs.filter{ $0.title.contains(searchText)}}
    var allSongs: AllSong { .init(displayingSong)}
    
    @Published var searchText = String()

    func fetch(for filters: [Song.QueryFilter]) async {
        let songs = await SongRepo.shared.fetch(filters, limit: 10)
        DispatchQueue.main.async {[weak self] in
            self?.songs = songs
            self?.objectWillChange.send()
        }
    }
}
