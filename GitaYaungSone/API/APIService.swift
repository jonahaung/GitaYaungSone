//
//  APIService.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 06/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct APIService {
    
    struct Constants {
        static let itemPath = "songs"
        static let itemRef = Firestore.firestore().collection(itemPath)
    }
    static let shared = APIService()
    
    func GET<T: Codable>(query: Query) async -> [T] {
        do {
            let snapshot = try await query.getDocuments()
            return snapshot.documents.compactMap { try? $0.data(as: T.self)}
        } catch {
            fatalError()
        }
    }
}
