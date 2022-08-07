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
    
    func task() async {
        song.popularity += 1
        SongRepo.shared.update(song)
    }

}

extension Song {
    
    struct Line: Hashable, Identifiable {
        
        enum LineType {
            case Directive, Lyric, Texts, Chords, Empty
        }
        
        let id = UUID()
        let lineType: LineType
        var chordTexts: [ChordText] = []
        var comment: String? = nil
        
        struct ChordText: Hashable, Identifiable {
            let id = UUID()
            var text: String
            var chord: Chord?
        }
    }
    
    func lines() -> [Line] {
        SongParser.songLines(rawText: rawText)
    }
    
    func attributedText(isDark: Bool = true) -> NSMutableAttributedString {
        func titleAttributedText() -> NSMutableAttributedString {
            let mutable = NSMutableAttributedString()
            mutable.append(.init(string: title, attributes: [.font: XFont.title(for: title), .foregroundColor: isDark ? UIColor.label : .black]))
            mutable.append(.init(string: artist.newLine.prepending("\n"), attributes: [.font: XFont.universal(for: .footnote), .foregroundColor: isDark ? UIColor.secondaryLabel : .darkGray]))
            return mutable
        }
        
        let attrText = titleAttributedText()
        
        let font = XFont.body(for: rawText)
        let cFont = XFont.chord()
        
        self.lines().forEach { line in
            var chordLine = String()
            var wordLine = String()
            line.chordTexts.forEach { part in
                if let chord = part.chord {
                    chordLine += chord.name
                }
                
                wordLine += part.text.whiteSpace
                while chordLine.widthOfString(usingFont: cFont) + cFont.pointSize < wordLine.widthOfString(usingFont: font) {
                    chordLine += " "
                }
                chordLine += " "
            }
            attrText.append(.init(string: chordLine.newLine, attributes: [.font: cFont, .foregroundColor: isDark ? UIColor.systemOrange : UIColor.systemPink]))
            attrText.append(.init(string: wordLine.newLine, attributes: [.font: font, .foregroundColor: isDark ? UIColor.label : .black]))
        }
        attrText.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.nonLineBreak, range: rawText.nsRange())
        return attrText
    }
}
