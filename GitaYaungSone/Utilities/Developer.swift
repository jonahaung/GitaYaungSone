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
        let demos: [Artist] = {
            let names = ["Aung Yin", "Lay Phyu", "Angel", "Myo Gyi", "Sai Htee Sai", "Han Htoo Lwin", "May Sweet", "Sai Sai Kham Hlaing", "Raymond", "Aye Chan May", "Wine Suu Khaing Thein", "Victor Khin Nyo", "Wai La", "Hlwan Moe", "Khaing Htoo", "Htoo Ein Thin", "Aung Naing", "Kai Zar", "Khin Maung Toe", "Khin Maung Htoo"]
            return names.map{ Artist(name: $0)}
        }()
        let store = Firestore.firestore().collection("artists")
        demos.forEach { artist in
            do {
                let result = try store.addDocument(from: artist)
                print(result)
            } catch {
                print(error)
            }
        }
    }
}
