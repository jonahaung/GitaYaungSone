//
//  SearchResultCell.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 9/5/22.
//

import SwiftUI

struct SearchResultCell: View {
    let result: Song.QueryFilter
    var body: some View {
        HStack {
            Text(result.value)
                .font(XFont.universal(for: .callout).font)
            Spacer()
            Text(result.key)
                .italic()
                .foregroundStyle(.tertiary)
        }
        .tapToPush(ExplorerView(filters: [result]))
    }
}
