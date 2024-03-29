//
//  ArtistViewModel.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import Foundation

final class ArtistViewModel: ObservableObject {

    private var songs = [Song]()
    var displayingSong: [Song] { searchText.isEmpty ? songs : songs.filter{ $0.title.contains(searchText)}}
    var allSongs: AllSong { .init(displayingSong)}

    @Published var searchText = String()

    func fetch(for artist: Artist) async {
        let songs = await SongRepo.shared.fetch([.artist(artist.name)])
        DispatchQueue.main.async {[weak self] in
            self?.songs = songs
            self?.objectWillChange.send()
        }

        if var artist = await ArtistRepo.shared.fetch([.name(artist.name)]).first {
            artist.popularity += 1
            ArtistRepo.shared.update(artist)
        } else {
            var artist = Artist(name: artist.name)
            artist.popularity = 1
            ArtistRepo.shared.add(artist)
        }
    }

    
}
