//
//  SongParser.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 2/5/22.
//

import Foundation

struct SongParser {
    
    static func parseProperties(song: inout Song) {
        song.rawText.lines().forEach { textLine in
            if textLine.starts(with: "{") {
                parseProperties(textLine, song: &song)
            }
        }
    }
    
    static func songLines(rawText: String) -> [Song.Line] {
        
        var lines = [Song.Line]()
        rawText.lines().forEach { rawLine in
            if !rawLine.starts(with: "{") && !rawLine.starts(with: "#") {
                let line = parseLine(rawLine)
                lines.append(line)
            }
        }
        return lines
    }
    
    static func song(_ string: String) -> Song {
        var song = Song(rawText: string)
        parseProperties(song: &song)
        return song
    }
    
    private static func parseLine(_ textLine: String) -> Song.Line {
        var chordTexts = [Song.Line.ChordText]()
        
        RegularExpression.lyricsPattern.matches(in: textLine, range: textLine.nsRange()).forEach { result in
            var chord = String()
            var text = String()
            
            if let range = Range(result.range(at: 1), in: textLine) {
                let bracked = String(textLine[range])
                chord = RegularExpression.chordPattern.stringByReplacingMatches(in: bracked, withTemplate: "$1")
                
            }
            
            if let range = Range(result.range(at: 2), in: textLine) {
                text = String(textLine[range])
            }
            if text.isWhitespace {
                let chordText = Song.Line.ChordText(chord: chord, text: text)
                chordTexts.append(chordText)
            } else {
                for (i, word) in text.words().enumerated() {
                    if i == 0 {
                        let chordText = Song.Line.ChordText(chord: chord, text: word)
                        chordTexts.append(chordText)
                    } else {
                        chordTexts.append(.init(chord: String(), text: word))
                    }
                }
            }
        }
        return Song.Line(chordTexts: chordTexts)
    }
    
    private static func parseProperties(_ textLine: String, song: inout Song) {
        if let match = RegularExpression.directivePattern.firstMatch(in: textLine, range: textLine.nsRange()) {
            var key = String()
            var value = String()
            
            if let keyRange = Range(match.range(at: 1), in: textLine) {
                key = String(textLine[keyRange]).trimmed()
            }
            if let valRange = Range(match.range(at: 2), in: textLine) {
                value = String(textLine[valRange]).trimmed()
                if !value.isWhitespace {
                    switch key {
                    case "t", "title":
                        song.title = value
                    case "st", "subtitle", "artist":
                        song.artist = value
                    case "key":
                        song.key = value
                    case "album":
                        song.album = value
                    case "tempo":
                        song.tempo = value
                    default:
                        break
                    }
                }
                
            }
        }
    }
}
