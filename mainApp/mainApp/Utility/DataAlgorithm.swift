//
//  DataAlgorithm.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import CryptoKit

final class DataAlgorithm {
    
    var cardName: String = ""
    var password: String = ""
    var plainText: String = ""
    var cipherText: String = ""
    
    func generateSymmetricKey(cardName: String, password: String) -> SymmetricKey? {
        let combinedString = "\(cardName)\(password)"
        if let data = combinedString.data(using: .utf8) {
            let hash = SHA256.hash(data: data)
            return SymmetricKey(data: hash)
        }
        
        return nil
    }
    
    func toCipher(cardName: String, password: String, plainText: String)  -> (Bool, cipherText: String) {
        
        // Get SymmetricKey
        if let symmetricKey: SymmetricKey = generateSymmetricKey(cardName: cardName, password: password) {
            // Convert String to Data
            if let plaintextData: Data = plainText.data(using: .utf8) {
                do {
                    //Encrypt
                    let sealedBox = try AES.GCM.seal(plaintextData, using: symmetricKey)
                    
//                    let combine = sealedBox.combined?.base64EncodedString() {
//                    return (true, combine)
                    if let combine = sealedBox.combined {
                        return (true, combine.base64EncodedString())
                    } else {
                        return (false, "BASE64 Encode Error")
                    }
                        
                } catch {
                    print("Error: \(error)")
                    return (false, "Encrypt Error")
                }
            } else {
                return (false, "Convert String to Data Error")
            }
        } else {
            return (false, "Get SymmetricKey Error")
        }
    }
    
    func toPlain(cardName: String, password: String, cipherText: String)  -> (Bool, plainText: String) {
        
        // Get SymmetricKey
        if let symmetricKey: SymmetricKey = generateSymmetricKey(cardName: cardName, password: password) {
            // Convert base64String to Data
            if let ciphertextData: Data = Data(base64Encoded: cipherText) {
                do {
                    //Decrypt
                    let sealedBoxToOpen = try AES.GCM.SealedBox(combined: ciphertextData)
                    let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: symmetricKey)
                    
//                    let decryptedString = String(data: decryptedData, encoding: .utf8) ?? "UTF8 encode Error"
//                    return (true, decryptedString)
                    if let decryptedString = String(data: decryptedData, encoding: .utf8) {
                        return (true, decryptedString)
                    } else {
                        return (true, "UTF8 encode Error")
                    }
                    
                } catch {
                    print("Error: \(error)")
                    return (false, "Decrypt Error")
                }
            } else {
                return (false, "Convert base64String to Data Error")
            }
        } else {
            return (false, "Get SymmetricKey Error")
        }
    }
    
    func action(cardName: String, password: String, words: String)  -> (Bool, cipherText: String, plainText: String) {
        var cipherBox: String = ""
        var plainBox: String = ""
        var answer: Bool = false
        
        let (istoCipherSuccess, toCipherAnswer) = toCipher(cardName: cardName, password: password, plainText: words)
        answer = istoCipherSuccess
        cipherBox = toCipherAnswer
        if !answer {
            return (answer, cipherBox, plainBox)
        }

        let (istoPlainSuccess, toPlainAnswer) = toPlain(cardName: cardName, password: password, cipherText: cipherBox)
        answer = istoPlainSuccess
        plainBox = toPlainAnswer
        if !answer {
            return (answer, cipherBox, plainBox)
        }
        
        if !(words == plainBox) {
            return (false, cipherBox, plainBox)
        }

        return (answer, cipherBox, plainBox)
    }
    
    func clearData() {
        cardName = ""
        password = ""
        plainText = ""
        cipherText = ""
    }
}
