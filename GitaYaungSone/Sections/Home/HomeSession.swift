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
                        XSectionTitleView(title: "Artists/Bands") {
                            SingerTagsView()
                        }
                        XSectionTitleView(title: "Suggestions") {
                            XSectionView {
                                HomeExplorerView()
                            }
                        }
                        XSectionTitleView(title: "Genres") {
                            GenreTagsView()
                                .padding(.horizontal)
                        }
                    }
                    .opacity(0.8)
                }
            }
        }
        .embeddedInNavigationView()
    }
}
