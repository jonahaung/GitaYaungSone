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
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Artists/Bands")
                                .foregroundStyle(.tertiary)
                                .padding(.horizontal)
                            SingerTagsView()
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Genres")
                                .foregroundStyle(.tertiary)
                            GenreTagsView()
                        }
                        .padding(.horizontal)
                        
                        XSectionView {
                            HomeExplorerView()
                        }
                        
                    }
                }
            }
        }
        .embeddedInNavigationView()
    }
}
