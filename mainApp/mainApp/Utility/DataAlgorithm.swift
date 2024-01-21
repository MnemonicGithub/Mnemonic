//
//  DataAlgorithm.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import CryptoKit

public struct DataAlgorithm {
    
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
    
    func toCipher(cardName: String, password: String, plainText: String)  -> String? {
        
        // Get SymmetricKey
        if let symmetricKey: SymmetricKey = generateSymmetricKey(cardName: cardName, password: password) {
            // Convert String to Data
            if let plaintextData: Data = plainText.data(using: .utf8) {
                do {
                    //Encrypt
                    let sealedBox = try AES.GCM.seal(plaintextData, using: symmetricKey)
                    
                    let combine = sealedBox.combined?.base64EncodedString()
                    print("combine: \(String(describing: combine))")
                    return combine
                } catch {
                    print("Error: \(error)")
                    return "Encrypt Error"
                }
            } else {
                return "Convert String to Data Error"
            }
        } else {
            return "Get SymmetricKey Error"
        }
    }
    
    func toPlain(cardName: String, password: String, cipherText: String)  -> String?  {
        
        // Get SymmetricKey
        if let symmetricKey: SymmetricKey = generateSymmetricKey(cardName: cardName, password: password) {
            // Convert base64String to Data
            if let ciphertextData: Data = Data(base64Encoded: cipherText) {
                do {
                    //Decrypt
                    let sealedBoxToOpen = try AES.GCM.SealedBox(combined: ciphertextData)
                    let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: symmetricKey)
                    
                    let decryptedString = String(data: decryptedData, encoding: .utf8)
                    print("Plaintext: \(String(describing: decryptedString))")
                    return decryptedString
                } catch {
                    print("Error: \(error)")
                    return "Decrypt Error"
                }
            } else {
                return "Convert base64String to Data Error"
            }
        } else {
            return "Get SymmetricKey Error"
        }
    }
}
