//
//  EmbeddingInNavigationView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 2/5/22.
//

import SwiftUI
public struct EmbeddingInNavigationViewModifier: ViewModifier {
    
    let showCancelButton: Bool
    public func body(content: Content) -> some View {
        PickerNavigationView(showCancelButton: showCancelButton) {
            content
        }
        .customThemeStyle()
    }
}

public extension View {
    func embeddedInNavigationView(showCancelButton: Bool = false) -> some View {
        ModifiedContent(content: self, modifier: EmbeddingInNavigationViewModifier(showCancelButton: showCancelButton))
    }
}
