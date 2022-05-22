//
//  TextRecognizing.swift
//  MyanmarLens2
//
//  Created by Aung Ko Min on 19/5/21.
//

import UIKit
import SwiftyTesseract

final class TextRecognizer {

    private let tesseract = SwiftyTesseract.Tesseract.init(languages: [.burmese, .english]) {
        set(.preserveInterwordSpaces, value: .true)
      }

    
    deinit {
        print("Deinit: TextRecognizer")
    }
    private let backgroundQueue = DispatchQueue(label: "TextRecognizer")

    func detectTexts(from image: UIImage,  _ completion: @escaping (String?) -> Void) {
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            let string = try? self.tesseract.performOCR(on: image).get()
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                completion(string)
            }
        }
    }
}
