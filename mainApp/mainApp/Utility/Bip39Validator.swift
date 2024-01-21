//
//  Bip39Validator.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import CryptoKit

public struct Bip39Validator {
    let wordList = WordLists.english
    
    func isValidWord(_ word: String) -> Bool {
        
        let word = word
        return wordList.contains(word)
    }
    
    func isValidMnemonic(_ mnemonic: Array<String>) -> Bool {
        var bits = ""
        for word in mnemonic {
            guard let i = wordList.firstIndex(of: word) else { return false }
            bits += ("00000000000" + String(i, radix: 2)).suffix(11)
        }
        
        let dividerIndex = bits.count / 33 * 32
        let entropyBits = String(bits.prefix(dividerIndex))
        let checksumBits = String(bits.suffix(bits.count - dividerIndex))
        
        let regex = try! NSRegularExpression(pattern: "[01]{1,8}", options: .caseInsensitive)
        let entropyBytes = regex.matches(in: entropyBits, options: [], range: NSRange(location: 0, length: entropyBits.count)).map {
            UInt8(strtoul(String(entropyBits[Range($0.range, in: entropyBits)!]), nil, 2))
        }
        return checksumBits == deriveChecksumBits(entropyBytes)
    }
    
    func deriveChecksumBits(_ bytes: [UInt8]) -> String {
        let ENT = bytes.count * 8;
        let CS = ENT / 32
        
        let hash = SHA256.hash(data: bytes)
        let hashbits = String(hash.flatMap { ("00000000" + String($0, radix:2)).suffix(8) })
        return String(hashbits.prefix(CS))
    }
}
