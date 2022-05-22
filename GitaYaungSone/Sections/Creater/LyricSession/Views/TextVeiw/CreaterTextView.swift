//
//  CreaterTextView.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import UIKit

final class CreaterTextView: UITextView {
    
    private lazy var toolBar = ToolbarInputAccessory()
    private var tags = [XTag]()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureToolbar()
        backgroundColor = .secondarySystemBackground
        bounces = true
        alwaysBounceVertical = true
        keyboardDismissMode = .interactive
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureToolbar() {
        toolBar.configure(textView: self)
    }
    
    func detectChords() {
        tags.removeAll()
        guard let text = self.text else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let tags = ChordTagger.tags(for: text)
            DispatchQueue.main.async {
                self.tags = tags
                self.tags.forEach {
                    self.textStorage.addAttributes($0.attributes, range: $0.range)
                }
            }
        }
        
    }
    
    func set(string: String) {
        if text != string {
            text = string
        }
        detectChords()
    }
    
    func insert(text: String) {
        insertText(text.newLine)
        scrollToBottom()
    }
    
    func scrollToBottom() {
        let length = attributedText.string.utf16.count
        let range = NSMakeRange(length-1, 0)
        scrollRangeToVisible(range)
        selectedTextRange = self.textRange(from: endOfDocument, to: endOfDocument)
    }
}

import SwiftUI

extension CreaterTextView {
    
    struct SwiftUIView: UIViewRepresentable {
        
        @EnvironmentObject private var viewModel: CreaterViewModel
        
        func makeUIView(context: Context) -> CreaterTextView {
            let view = CreaterTextView()
            view.delegate = context.coordinator
            viewModel.textView = view
            return view
        }
        
        func updateUIView(_ uiView: CreaterTextView, context: Context) {
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(text: $viewModel.song.rawText)
        }
        
        class Coordinator: NSObject, UITextViewDelegate {
            private var text: Binding<String>
            
            init(text: Binding<String>) {
                self.text = text
            }
            
            func textViewDidChange(_ textView: UITextView) {
                text.wrappedValue = textView.text
                (textView as? CreaterTextView)?.detectChords()
            }
        }
    }
}


