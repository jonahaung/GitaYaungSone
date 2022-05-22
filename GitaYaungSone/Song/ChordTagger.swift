//
//  ChordTagger.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 2/5/22.
//

import UIKit

struct ChordTagger {
    
    static func tags(for text: String) -> [XTag] {
        var tags = [XTag]()
        text.enumerateSubstrings(in: text.startIndex..<text.endIndex, options: .byLines) {
            (substring, substringRange, _, _) in
            if let substring = substring {
                let nsRange = NSRange(substringRange, in: text)
                let string = String(substring)
                let tag = XTag.init(string: string, range: nsRange, font: XFont.body(for: string))
                tags.append(tag)
            }
        }
        
        RegularExpression.chordPattern.enumerateMatches(in: text, range: text.nsRange()) { result, _, _ in
            if let result = result {
                let range = result.range
                let str = (text as NSString).substring(with: range)
                let tag = XTag(string: String(str), range: range, font: XFont.chord(), foregroundColor: .blue)
                tags.append(tag)
            }
        }
        RegularExpression.chordsRegexForPlainText.enumerateMatches(in: text, range: text.nsRange()) { result, _, _ in
            if let result = result {
                let range = result.range
                let str = (text as NSString).substring(with: range)
                let tag = XTag(string: String(str), range: range, font: XFont.chord(), foregroundColor: .systemIndigo)
                tags.append(tag)
            }
        }
        return tags
    }
}
