//
//  AllSongs.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import Foundation
import CoreData
import SwiftUI

struct AllSong {
    let id = UUID().uuidString
    
    let songs: [Song]
    
    var artists: [Artist] {
        Dictionary(grouping: songs, by: { $0.artist }).map{ Artist(name: $0.key, albums: albums(from: $0.value))}.sorted{ $0.name < $1.name }
    }
    
    var albums: [Artist.Album] {
        self.albums(from: songs)
    }
    var allSongsCount: Int { songs.count }
    init(_ songs: [Song]) {
        self.songs = songs
        
    }
    
    func albums(from songs: [Song]) -> [Artist.Album] {
        Dictionary(grouping: songs, by: { $0.album }).map{ Artist.Album(name: $0.key, songs: $0.value )}
            .sorted{ $0.name < $1.name }
    }
   
}

extension AllSong {
    struct Artist: Identifiable {
        
        var id: String { name }
        let name: String
        let albums: [Album]
        
        var songs: [Song] {
            var items = [Song]()
            albums.forEach { album in
                items += album.songs
            }
            return items
        }
        struct Album: Identifiable {
            var id: String { name }
            let name: String
            let songs: [Song]
        }
    }
}
