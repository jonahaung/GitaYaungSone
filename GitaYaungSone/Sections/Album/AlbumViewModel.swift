//
//  AlbumViewModel.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import Foundation
import SwiftUI

final class AlbumViewModel: ObservableObject {

    private var songs = [Song]()
    var displayingSong: [Song] { searchText.isEmpty ? songs : songs.filter{ $0.title.contains(searchText)}}

    @Published var searchText = String()

    func fetch(for album: Album) async {
        let songs = await SongRepo.shared.fetch([.album(album.name)])
        if var album = await AlbumRepo.shared.fetch([.name(album.name)]).first {
            album.popularity += 1
            let artists = Array(Set(songs.map{$0.artist}))
            if artists.count == 1, let first = artists.first {
                album.artist = first
            } else {
                album.artist = "Various Artists"
            }

            AlbumRepo.shared.update(album)
        } else {
            var album = Album(name: album.name)
            album.popularity = 1
            let artists = Array(Set(songs.map{$0.artist}))
            if artists.count == 1, let first = artists.first {
                album.artist = first
            } else {
                album.artist = "Various Artists"
            }
            
            AlbumRepo.shared.add(album)
        }

        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.songs = songs
            withAnimation {
                self.objectWillChange.send()
            }
        }
    }
}
