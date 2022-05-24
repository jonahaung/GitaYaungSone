//
//  GenreTagsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct GenreTagsView: View {
    var body: some View {
        XSectionTitleView(title: "Genres") {
            AutoWrap(Genre.allCases, id: \.self, vSpacing: 5, hSpacing: 5) { genre in
                Tag(genre.rawValue, fgcolor: .secondary, bgcolor: .init(uiColor: .separator))
                    .tapToPush(ExplorerView(filters: [.genre(genre.rawValue)]))
            }
        }
        .padding(.horizontal)
    }
}

