//
//  CreaterFormViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation
import Combine

final class CreaterViewModel: ObservableObject {
    
    weak var textView: CreaterTextView?

    @Published var song = Song()
    @Published var showForm = false
    
    init() {
        setupSubscriptions()
    }
    
    func validate() {
        showForm = song.hasNotFilledForm
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private func setupSubscriptions() {
        $song
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap{$0}
            .sink { [weak self] song in
                self?.textView?.set(string: song.rawText)
            }
            .store(in: &subscriptions)
    }
}
