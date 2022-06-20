//
//  Repo.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Repo {
    
    static func add<T: Codable & Identifiable>(_ item: T, to ref: CollectionReference, completion: ((Error?)-> Void)? = nil) {
        do {
            _ = try ref.addDocument(from: item, completion: completion)
        } catch {
            completion?(error)
        }
    }
    
    static func update<T: Codable & Identifiable>(_ item: T, to ref: CollectionReference, completion: ((Error?)-> Void)? = nil) {
        guard let id = item.id as? String else {
            completion?(nil)
            return
        }
        do {
            _ = try ref.document(id).setData(from: item, completion: completion)
        } catch {
            completion?(error)
        }
    }
    
    static func remove<T: Codable & Identifiable>(_ item: T, to ref: CollectionReference, completion: ((Error?)-> Void)? = nil) {
        guard let id = item.id as? String else {
            completion?(nil)
            return
        }
        ref.document(id).delete(completion: completion)
    }
    
    static func fetch<T: Codable>(query: Query) async -> [T] {
        do {
            let snapshot = try await query.getDocuments()
            return snapshot.documents.compactMap { try? $0.data(as: T.self)}
        } catch {
            print(error)
            return []
        }
    }
}
