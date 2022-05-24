//
//  AppLogoView.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 24/5/22.
//

import SwiftUI

struct AppLogoView: View {
    let fontSize: CGFloat
    var body: some View {
        Text("ဂီတရောင်စုံ")
            .font(.custom(XFont.MyanmarFont.MasterpieceSpringRev.description, size: fontSize))
            .foregroundColor(.brown)
    }
}
