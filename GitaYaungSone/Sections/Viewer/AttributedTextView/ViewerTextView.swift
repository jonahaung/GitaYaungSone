//
//  ViewerTextView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 8/5/22.
//

import UIKit

final class ViewerTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isEditable = false
        isSelectable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(song: Song) {
        attributedText = song.attributedText()
    }
}

import SwiftUI

extension ViewerTextView {
    struct SwiftUIView: UIViewRepresentable {
        
        @EnvironmentObject private var viewModel: ViewerViewModel
        
        func makeUIView(context: Context) -> ViewerTextView {
            let view = ViewerTextView()
            
            viewModel.textView = view
            return view
        }
        
        func updateUIView(_ uiView: ViewerTextView, context: Context) {
            uiView.set(song: viewModel.song)
        }
        
        
    }
}
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

}
