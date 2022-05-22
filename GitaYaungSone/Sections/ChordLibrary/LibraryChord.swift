//
//  Chord.swift
//  
//
//  Created by Aung Ko Min on 12/12/2021.
//

import Foundation

public struct LibraryChord: Hashable, Equatable, Decodable {
    
    let key: String
    let suffix: String
    let positions: [Position]
    
    public struct Position: Hashable, Equatable, Decodable {
        let baseFret: Int
        let barres: [Int]
        let frets: [Int]
        let fingers: [Int]
    }
}
