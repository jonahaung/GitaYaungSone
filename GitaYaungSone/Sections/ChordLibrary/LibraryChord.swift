//
//  Chord.swift
//  
//
//  Created by Aung Ko Min on 12/12/2021.
//

import Foundation

public struct LibraryChord: Hashable, Equatable, Decodable, Identifiable {
    public var id: String { UUID().uuidString }
    let key: String
    let suffix: String
    let positions: [Position]
    
    public struct Position: Hashable, Equatable, Decodable, Identifiable {
        public var id: String { UUID().uuidString }
        let baseFret: Int
        let barres: [Int]
        let frets: [Int]
        let fingers: [Int]
    }
}
