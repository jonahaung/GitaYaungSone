//
//  Artist.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 22/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Artist: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    var albums = 0
    var popularity = 0
}


