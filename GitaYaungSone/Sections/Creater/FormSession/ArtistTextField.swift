//
//  ArtistUITextField.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 24/4/22.
//

import SwiftUI

struct ArtistTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> AutoCompleteTextField {
        let textField = AutoCompleteTextField(frame: .zero, dataSource: context.coordinator, delegate: context.coordinator)
        textField.placeholder = "Singer / Artist"
        textField.ignoreCase = false
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange(_:)), for: .editingChanged)
        textField.adjustsFontSizeToFitWidth = true
        textField.autoresizingMask = .flexibleWidth
        return textField
    }
    
    func updateUIView(_ uiView: AutoCompleteTextField, context: Context) {
        if uiView.isFirstResponder == false {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
}

extension ArtistTextField {
    
    class Coordinator: NSObject, ACTFDataSource, UITextFieldDelegate {
        
        var weightedDomains: [AutoCompleteData] = Artist.demos.map{ .init(text: $0.name, weight: 0)}
        
        private var text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        func autoCompleteTextFieldDataSource(_ autoCompleteTextField: AutoCompleteTextField) -> [AutoCompleteData] {
            weightedDomains
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == " " {
                (textField as? AutoCompleteTextField)?.commitAutocompleteText()
            }
            return true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            text.wrappedValue = textField.text ?? ""
        }
    }
}
