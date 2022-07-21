//
//  Song.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Song: Codable, Identifiable {
    @DocumentID var id: String?
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
