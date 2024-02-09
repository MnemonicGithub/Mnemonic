//
//  Bip39ValidatorViewModel.swift
//  mainApp
//
//  Created by Andy on 1/15/24.
//

import Foundation
import Combine

class Bip39ValidatorViewModel: ObservableObject {
    // Input
    @Published var word = ""
    @Published var mnemonic = ""
    
    // Output
    @Published var isValidWord = false
    @Published var isValidMnemonic = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var bip39Validator = Bip39Validator()
    
    init() {
        $word
            .receive(on: RunLoop.main)
            .map { word in
                return self.bip39Validator.isValidWord(word)
            }
            .assign(to: \.isValidWord, on: self)
            .store(in: &cancellableSet)
        
        $mnemonic
            .receive(on: RunLoop.main)
            .map { mnemonic in
                let words = mnemonic.components(separatedBy: " ")
                return self.bip39Validator.isValidMnemonic(words)
            }
            .assign(to: \.isValidMnemonic, on: self)
            .store(in: &cancellableSet)
    }
    
    func clearData() {
        word = ""
        mnemonic = ""
    }
}
