//
//  Song.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation

struct Song: Codable, Identifiable {
    var id = UUID().uuidString
    var title = String()
    var artists = [String]()
    var composer = String()
    var album = String()
    var key = String()
    var tempo = String()
    var genre = String()
    var mediaLink = String()
    var rawText = String()
    var created = Date()
    var createrID = String()
    var artist = String()
    var popularity = 0
}
