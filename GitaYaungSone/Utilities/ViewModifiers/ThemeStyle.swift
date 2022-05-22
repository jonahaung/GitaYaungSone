//
//  ThemeStyle.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 23/5/22.
//

import SwiftUI

private struct ThemeStyle: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(.dark)
            .accentColor(XApp.accentColor)
            .statusBar(hidden: true)
    }
}

public extension View {
    func customThemeStyle() -> some View {
        ModifiedContent(content: self, modifier: ThemeStyle())
    }
}
