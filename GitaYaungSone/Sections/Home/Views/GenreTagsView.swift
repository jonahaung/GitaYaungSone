//
//  GenreTagsView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct GenreTagsView: View {
    var body: some View {
        AutoWrap(Genre.allCases, id: \.self, vSpacing: 5, hSpacing: 5) { genre in
            Tag(genre.rawValue, fgcolor: .white, bgcolor: .init(uiColor: .separator))
                .tapToPush(ExplorerView(SearchItem(text: genre.rawValue, property: .genre)))
        }
    }
}

