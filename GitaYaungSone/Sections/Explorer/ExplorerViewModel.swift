//
//  ExplorerViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import Foundation

final class ExplorerViewModel: ObservableObject {
    
    @Published var songs = [Song]()

    func fetch(for filters: [Song.QueryFilter]) async {
        guard songs.isEmpty else { return }
        let songs = await SongRepo.shared.fetch(filters)
        DispatchQueue.main.async {[weak self] in
            self?.songs = songs
        }
    }
}


