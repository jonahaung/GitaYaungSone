//
//  AdminPannelView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 13/8/22.
//

import SwiftUI

struct AdminPannelView: View {
    var body: some View {
        List {
            Text("Artist")
                .tapToPush(AdminArtistView())
        }.navigationTitle("Admin")
    }
}
