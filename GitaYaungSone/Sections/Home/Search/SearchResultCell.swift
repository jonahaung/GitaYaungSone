//
//  SearchResultCell.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct SearchResultCell: View {
    let result: SearchItem
    var body: some View {
        HStack {
            Text(result.text)
                .font(XFont.universal(for: .callout).font)
            Spacer()
            Text(result.property.rawValue)
                .italic()
                .foregroundStyle(.tertiary)
        }
        .tapToPush(ExplorerView(result))
    }
}
