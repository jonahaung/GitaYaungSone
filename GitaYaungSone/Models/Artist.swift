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


// Mock
extension Artist {
    static let demos: [Artist] = {
        let names = ["Aung Yin", "Lay Phyu", "Angel", "Myo Gyi", "Sai Htee Sai", "Han Htoo Lwin", "May Sweet", "Sai Sai Kham Hlaing", "Raymond", "Aye Chan May", "Wine Suu Khaing Thein", "Victor Khin Nyo", "Wai La", "Hlwan Moe", "Khaing Htoo", "Htoo Ein Thin", "Aung Naing", "Kai Zar", "Khin Maung Toe", "Khin Maung Htoo"]
        return names.map{ Artist(name: $0)}
    }()
    
    static var populars: [Artist] {
        demos
    }
}
