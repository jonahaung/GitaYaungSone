//
//  BikeRepository.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ItemRepository: ObservableObject {
    
    static let shared = ItemRepository()
    
    func add<T: Codable>(_ item: T, completion: @escaping (Error?)-> Void) {
        do {
            _ = try APIService.Constants.itemRef.addDocument(from: item, completion: completion)
        } catch {
            completion(error)
        }
    }
    
    func update<T: Codable & Identifiable>(_ item: T, completion: @escaping (Error?)-> Void) {
        do {
            try APIService.Constants.itemRef.document(item.id as! String).setData(from: item, completion: completion)
        } catch {
            completion(error)
        }
    }
    
    func remove<T: Codable & Identifiable>(_ item: T, completion: @escaping (Error?)-> Void) {
        APIService.Constants.itemRef.document(item.id as! String).delete(completion: completion)
    }
}
