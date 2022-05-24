//
//  FormCell.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 25/4/22.
//

import SwiftUI

struct FormCell<Content: View>: View {
    
    let icon: XIcon.Icon
    var color = Color.secondary
    let content: () -> Content
    
    var body: some View {
        HStack(alignment: .bottom) {
            XIcon(icon)
                .foregroundColor(color)
                .frame(width: 25, height: 25)
            content()
        }.frame(maxWidth: .infinity)
    }
}

struct FormCell2<Content: View>: View {
    
    let left: () -> Content
    let right: () -> Content
    
    var body: some View {
        HStack {
            left()
            Spacer()
            right()
                .foregroundStyle(.secondary)
        }
    }
}
