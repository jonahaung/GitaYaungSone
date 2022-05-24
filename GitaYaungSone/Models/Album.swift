//
//  Album.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import Foundation
struct Album: Codable, Identifiable {
    var id: String { name }
    let name: String
    var popularity = 0
}
