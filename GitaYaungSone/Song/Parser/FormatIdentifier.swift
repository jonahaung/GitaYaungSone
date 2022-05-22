//
//  FormatIdentifier.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 3/5/22.
//

import Foundation

struct FormatIdentifier {
    enum FormatType {
        case ChordPro, Plain
    }
    
    static func identify(_ string: String) -> FormatType {
        let plainMatches = RegularExpression.chordsRegexForPlainText.matches(in: string, range: string.nsRange())
        let chordProMatches = RegularExpression.chordPattern.matches(in: string, range: string.nsRange())
        return plainMatches.count > chordProMatches.count ? .Plain : .ChordPro
    }
    
    static func process(_ string: String) -> String {
        let format = identify(string)
        if format == .Plain {
            return PlainSongParser.parse(string)
        }
        return string
    }
}
