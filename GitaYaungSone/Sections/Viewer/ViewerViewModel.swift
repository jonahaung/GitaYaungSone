//
//  ViewerViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import UIKit

final class ViewerViewModel: ObservableObject {
    
    var song: Song
    weak var textView: ViewerTextView?
    
    init(_ song: Song) {
        self.song = song
    }
    func  task() async {
        song.popularity += 1
        SongRepo.shared.update(song)
        if var artist = await ArtistRepo.shared.fetch([.name(song.artist)]).first {
            artist.popularity += 1
            ArtistRepo.shared.update(artist)
        }
    }
}

extension Song {
    
    struct Line: Hashable, Identifiable {
        let id = UUID()
        var chordTexts = [ChordText]()
        
        struct ChordText: Hashable, Identifiable {
            let id = UUID()
            let chord: String
            let text: String
        }
    }
    
    func lines() -> [Line] {
        SongParser.songLines(rawText: rawText)
    }
    
    func attributedText() -> NSMutableAttributedString {
        func titleAttributedText() -> NSMutableAttributedString {
            let mutable = NSMutableAttributedString()
            mutable.append(.init(string: title, attributes: [.font: XFont.title(for: title), .foregroundColor: UIColor.label]))
            mutable.append(.init(string: artist.newLine.prepending("\n"), attributes: [.font: XFont.universal(for: .footnote), .foregroundColor: UIColor.secondaryLabel]))
            return mutable
        }
        
        let attrText = titleAttributedText()
        
        let font = XFont.body(for: rawText)
        let cFont = XFont.chord()
        
        self.lines().forEach { line in
            var chordLine = String()
            var wordLine = String()
            
            line.chordTexts.forEach { part in
                chordLine += part.chord
                wordLine += part.text.whiteSpace
                
                while chordLine.widthOfString(usingFont: cFont) + cFont.pointSize < wordLine.widthOfString(usingFont: font) {
                    chordLine += " "
                }
                chordLine += " "
            }
            attrText.append(.init(string: chordLine.newLine, attributes: [.font: cFont, .foregroundColor: UIColor.systemOrange]))
            attrText.append(.init(string: wordLine.newLine, attributes: [.font: font, .foregroundColor: UIColor.label]))
        }
        attrText.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.nonLineBreak, range: rawText.nsRange())
        return attrText
        
    }
}
