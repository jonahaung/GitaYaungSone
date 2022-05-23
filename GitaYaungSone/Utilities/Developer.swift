//
//  Developer.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 22/5/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Developer {
    
    static func upDateArtists() {
        Task {
            let songs = await SongRepo.shared.fetch([])
            for var song in songs {
                song.popularity += 1
                YSong.create(song: song)
                SongRepo.shared.update(song)
            }
        }
    }
}
