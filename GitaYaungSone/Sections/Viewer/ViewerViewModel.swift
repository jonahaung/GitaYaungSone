//
//  ViewerViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import UIKit

final class ViewerViewModel: ObservableObject {
    
    var song: Song
    var artist: Artist?
    var album: Album?
    @Published var fontSize = CGFloat(15)
    
    init(_ song: Song) {
        self.song = song
    }
    
    func task() async {
        song.popularity += 1
        SongRepo.shared.update(song)

        artist = await ArtistRepo.shared.fetch([.name(song.artist)]).first
        album = await AlbumRepo.shared.fetch([.name(song.album)]).first

        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
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
            mutable.append(.init(string: artist.newLine.prepending("  "), attributes: [.font: XFont.universal(for: .footnote), .foregroundColor: isDark ? UIColor.secondaryLabel : .darkGray]))
            return mutable
        }
        
        let attrText = titleAttributedText()
        
        let font = XFont.body(for: rawText)
        let cFont = XFont.chord()
        
        self.lines().forEach { line in
            switch line.lineType {
            case .Directive:
                if let comment = line.comment {
                    attrText.append(.init(string: comment.newLine, attributes: [.foregroundColor: UIColor.systemBrown, .font: cFont]))
                }
            case .Chords:
                let text = line.chordTexts.compactMap{$0.chord?.name}.joined(separator: " ")
                attrText.append(.init(string: text.newLine, attributes: [.foregroundColor: UIColor.systemPink, .font: cFont]))
            case .Texts:
                let text = line.chordTexts.map{$0.text}.joined(separator: " ")
                attrText.append(.init(string: text.newLine, attributes: [.font: font]))
            case .Lyric:
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
            case .Empty:
                attrText.append(.init(string: "\n"))
            }
        }
        attrText.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.nonLineBreak, range: rawText.nsRange())
        return attrText
    }
}
extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
