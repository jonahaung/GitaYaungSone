//
//  AlbumRepo.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import Foundation

import Foundation
import FirebaseFirestore

class AlbumRepo {
    
    static let shared = AlbumRepo()
    let reference = Firestore.firestore().collection("albums")
    
    func add(_ item: Album, completion: ((Error?) -> Void)? = nil) {
        Repo.add(item, to: reference, completion: completion)
    }
    
    func update(_ item: Album, completion: ((Error?) -> Void)? = nil) {
        Repo.update(item, to: reference, completion: completion)
    }
    
    func remove(_ item: Album, completion: @escaping (Error?)-> Void) {
        Repo.remove(item, to: reference, completion: completion)
    }
    
    func fetch(_ queryItems: [Album.QueryFilter]) async -> [Album] {
        var query = reference as Query
        queryItems.forEach {
            query = query.whereField($0.key, isEqualTo: $0.value)
        }
        
        return await Repo.fetch(query: query)
    }
    
    func search(_ queryItems: [Album.QueryFilter], limit: Int) async -> [Album] {
        var query = reference as Query
        queryItems.forEach {
            query = query
                .whereField($0.key, isGreaterThanOrEqualTo: $0.value)
                .whereField($0.key, isLessThan: $0.value + "\u{f8ff}")
        }
        query = query.limit(to: limit)
        return await Repo.fetch(query: query)
    }
}

extension Album {
    
    enum QueryFilter: Hashable, Identifiable {
        var id: Album.QueryFilter { self }
        case name(String)
        
        var key: String {
            switch self {
            case .name:
                return "name"
            }
        }
        
        var value: String {
            switch self {
            case .name(let string):
                return string
            }
        }
    }
}
