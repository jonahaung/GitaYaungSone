//
//  ViewerViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 28/4/22.
//

import Foundation

final class ViewerViewModel: ObservableObject {
    
    var song: Song
    weak var textView: ViewerTextView?
    
    init(_ song: Song) {
        self.song = song
    }
}
