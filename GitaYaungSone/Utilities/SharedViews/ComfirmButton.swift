//
//  ComfirmButton.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import SwiftUI

struct ComfirmButton<Content: View>: View {
    
    
    let buttonText: String
    var action: () -> Void
    let label: () -> Content
    @State private var showDialog = false
    
    var body: some View {
        Button {
            showDialog = true
        } label: {
            label()
        }
        .confirmationDialog("Dialog", isPresented: $showDialog, actions: {
            Button(buttonText, role: .none) {
                action()
            }
            
        }).labelsHidden()
    }
    
    
}
