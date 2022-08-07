//
//  HomeSession.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import SwiftUI

struct HomeSession: View {
    var body: some View {
        HomeSessionNavItemsView {
            XScrollView {
                RemoteSearchableView {
                    LazyVStack {
                        SingerTagsView()
                        PopularSongsView()
                        PopularAlbumsView()
                        GenreTagsView()
                    }
                }
            }
            .background(Image("disc")
            .resizable()
            .scaledToFit())
        }
        .embeddedInNavigationView()
    }
}
