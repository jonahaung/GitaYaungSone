//
//  AdminArtistView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 13/8/22.
//

import SwiftUI

struct AdminArtistView: View {

    @State private var artists = [Artist]()
    var body: some View {
        List {
            ForEach(artists) { artist in
                Text(artist.name)
                    .tapToPush(AdminArtistEditView(artist: artist))
            }
        }
        .navigationTitle("Admin/Artist")
        .task {
            artists = await ArtistRepo.shared.fetch([])
        }
    }
}
