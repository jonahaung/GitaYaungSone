//
//  AdminArtistEditView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 13/8/22.
//

import SwiftUI

struct AdminArtistEditView: View {

    @State var artist: Artist
    @State private var name = ""
    @State private var photoUrl = ""

    var body: some View {
        List {
            Section(header: profilePhotoView) {
                TextField("Artist Name", text: $name)
                TextField("Artist Photo", text: $photoUrl)
                Text(artist.popularity.description)
            }
        }.task {
            name = artist.name
            photoUrl = artist.photoURL ?? ""
        }
        .navigationBarItems(trailing: trailingButton)
    }

    private var trailingButton: some View {
        Button("Save") {
            artist.photoURL = photoUrl
            artist.name = name
            ArtistRepo.shared.update(artist)
        }
        .disabled(savedButtonDisabled)
    }

    private var savedButtonDisabled: Bool {
        artist.name == name && artist.photoURL == photoUrl
    }

    private var profilePhotoView: some View {
        CachedAsyncImage(url: URL(string: photoUrl)) { image in
            image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(5)
        } placeholder: {
            VStack {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 250)
        }

    }
}
