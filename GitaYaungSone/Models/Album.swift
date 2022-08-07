//
//  Album.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Album: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    var popularity = 0
    var artist: String?
}
