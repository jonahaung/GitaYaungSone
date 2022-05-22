//
//  +String.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 18/3/22.
//

import UIKit

extension String: Identifiable {
    public var id: String { self }
}
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
extension Optional where Wrapped == String {
    var str: String {
        return self ?? ""
    }
}

extension CharacterSet {

    static let myanmarAlphabets = CharacterSet(charactersIn: "ကခဂဃငစဆဇဈညတဒဍဓဎထဋဌနဏပဖဗဘမယရလ၀သဟဠအ").union(.whitespacesAndNewlines)
    static var englishAlphabets = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    static var lineEnding = CharacterSet(charactersIn: ".?!;:။…\t")
    static let guitarKeys = CharacterSet(charactersIn: "ABCDEFGm#baugsus567")
}
extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        NSRange(range, in: self)
    }
    
    static func makeEmptyString(for i: Int, with item: String = " ") -> String {
        var str = String()
        (0..<i).forEach { _ in
            str += item

        }
        return str
    }
    
    var language: String { NSLinguisticTagger.dominantLanguage(for: self) ?? ""}
    var isMyanar: Bool { language == "my" }
    var isEnglish: Bool { language == "eng" }
    
    var nsString: NSString {
        self as NSString
    }
}


extension String {
    
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    var isWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var whiteSpace: String {
        self.appending(" ")
    }
    func prepending(_ string: String) -> String {
        string + self
    }
    var newLine: String {
        self.appending("\r")
    }
    
    var nonLineBreak: String {
        self.replacingOccurrences(of: " ", with: "\u{00a0}")
    }
}
extension String {

    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
}

extension String {
    
    func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    func words() -> [String] {
        let comps = components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return comps.filter { !$0.isWhitespace }
    }
    
    func wordTags() -> [(string: String, range: NSRange)] {
        var ranges = [(String, NSRange)]()
        self.enumerateSubstrings(in: self.startIndex..<self.endIndex, options: [.byWords]) {
            (word, textRange, _, _) in
            if let word = word {
                let wordRange = self.nsRange(from: textRange)
                ranges.append((String(word), wordRange))
            }
        }
        return ranges
    }
    
    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func nsRange() -> NSRange {
        NSRange.init(self.startIndex..<self.endIndex, in: self)
    }
}
