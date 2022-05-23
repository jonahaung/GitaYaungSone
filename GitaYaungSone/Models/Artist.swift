//
//  Artist.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 22/5/22.
//

import Foundation

struct Artist: Codable, Identifiable {
    var id: String { name }
    let name: String
    var songs = 0
    var albums = 0
    var popularity = 0
}


