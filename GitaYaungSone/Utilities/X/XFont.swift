//
//  XFont.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 17/3/22.
//

import SwiftUI

struct XFont {

    enum MyanmarFont: String, CustomStringConvertible {
        var description: String { rawValue.replacingOccurrences(of: "_", with: "-")}
        
        case MyanmarSansPro, MyanmarAngoun, MyanmarSquare, MasterpieceSpringRev, NotoSansMyanmar_Regular
    }
    enum Style {
        case title, headline, body, subheadline, footnote
        var size: CGFloat {
            switch self {
            case .title:
                return UIFont.preferredFont(forTextStyle: .title1).pointSize
            case .headline:
                return UIFont.preferredFont(forTextStyle: .headline).pointSize
            case .body:
                return UIFont.preferredFont(forTextStyle: .body).pointSize
            case .subheadline:
                return UIFont.preferredFont(forTextStyle: .subheadline).pointSize
            case .footnote:
                return UIFont.preferredFont(forTextStyle: .footnote).pointSize
            }
        }
    }
    
    // Automatic Fonts
    static func title(for text: String) -> UIFont {
        let isMyanmar = text.isMyanar
        let size = isMyanmar ? 42 : UIFont.preferredFont(forTextStyle: .title1).pointSize
        let fontName = isMyanmar ? MyanmarFont.MasterpieceSpringRev.rawValue : "NotoSansMonoExtraCondensed-Bold"
        return UIFont(name: fontName, size: size)!
    }
    static func headline(for text: String) -> UIFont {
        let fontName = text.isMyanar ? MyanmarFont.MyanmarSansPro.rawValue : "NotoSansMonoExtraCondensed-SemiBold"
        return .init(name: fontName, size: UIFont.buttonFontSize)!
    }
    static func subheadline(for text: String) -> UIFont {
        let fontName = text.isMyanar ? MyanmarFont.MyanmarSansPro.rawValue : "NotoSansMonoExtraCondensed-Regular"
        return UIFont(name: fontName, size: UIFont.systemFontSize)!
    }
    
    static func body(for text: String) -> UIFont {
        let fontName = text.isMyanar ? MyanmarFont.MyanmarAngoun.description : "NotoSansMonoExtraCondensed-Medium"
        return UIFont(name: fontName, size: UIFont.labelFontSize - 1)!
    }
    
    static func footnote(for text: String) -> UIFont {
        let fontName = text.isMyanar ? MyanmarFont.MyanmarSansPro.rawValue : "NotoSansMonoExtraCondensed-Regular"
        return .init(name: fontName, size: UIFont.systemFontSize)!
    }
    
    static func chord() -> UIFont {
        .init(name: "NotoSansMonoExtraCondensed-Medium", size: 16)!
    }
    static func tag() -> UIFont {
        .init(name: "NotoSansMonoExtraCondensed-Bold", size: 12)!
    }
    static func universal(for style: UIFont.TextStyle) -> UIFont {
        .init(name: MyanmarFont.MyanmarSansPro.rawValue, size: UIFont.preferredFont(forTextStyle: style).pointSize) ?? UIFont.preferredFont(forTextStyle: style)
    }
}

extension UIFont {
    var font: Font {
        .init(self)
    }
}
