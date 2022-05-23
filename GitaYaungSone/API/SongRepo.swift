//
//  BikeRepository.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import FirebaseFirestore

class SongRepo {
    
    static let shared = SongRepo()
    let reference = Firestore.firestore().collection("songs")
    
    func add(_ item: Song, completion: ((Error?) -> Void)? = nil) {
        Repo.add(item, to: reference, completion: completion)
    }
    
    func update(_ item: Song, completion: ((Error?) -> Void)? = nil) {
        Repo.update(item, to: reference, completion: completion)
    }
    
    func remove(_ item: Song, completion: @escaping (Error?)-> Void) {
        Repo.remove(item, to: reference, completion: completion)
    }
    
    func fetch(_ queryItems: [Song.QueryFilter]) async -> [Song] {
        var query = reference as Query
        queryItems.forEach {
            query = query.whereField($0.key, isEqualTo: $0.value)
        }
        return await Repo.fetch(query: query)
    }
    
    func search(_ queryItems: [Song.QueryFilter], limit: Int) async -> [Song] {
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


extension Song {
    
    enum QueryFilter: Hashable, Identifiable {
        var id: Song.QueryFilter { self }
        case title(String)
        case artist(String)
        case album(String)
        case composer(String)
        case genre(String)
        case createrId(String)
        
        var key: String {
            switch self {
            case .title:
                return "title"
            case .artist:
                return "artist"
            case .album:
                return "album"
            case .composer:
                return "composer"
            case .genre:
                return "genre"
            case .createrId:
                return "createrId"
            }
        }
        
        var value: String {
            switch self {
            case .title(let string):
                return string
            case .artist(let string):
                return string
            case .album(let string):
                return string
            case .composer(let string):
                return string
            case .genre(let string):
                return string
            case .createrId(let string):
                return string
            }
        }
    }
}
