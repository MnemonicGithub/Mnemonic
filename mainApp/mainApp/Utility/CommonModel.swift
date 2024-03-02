//
//  CommonModel.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct InAppReviewAlert {
    @AppStorage("isRate") var isRate: Bool = false
    @AppStorage("isInAppReview") var isInAppReview: Bool = false
    
    func setIsAlert() {
        isInAppReview = true
    }
    
    func closeIsAlert() {
        isInAppReview = false
    }
    
    func getIsAlert() -> Bool {
        return isInAppReview
    }
    
    func setIsRate() {
        isRate = true
    }
    
    func getIsRate() -> Bool {
        return isRate
    }
}

enum AppLink {
    static let appStore: String = "https://apps.apple.com/tw/app/safari/id1146562112"
    static let termsOfUse: String = "https://github.com/MnemonicGithub/Mnemonic"
    static let contactUs: String = "https://github.com/MnemonicGithub/Mnemonic"
    static let address: String = "0xCaB3f7146FF7ecC9551E9758C0D4e22B82573625"

}

final class DataBox: ObservableObject {
    @Published var actionW2CStep1: Bool = false
    @Published var actionW2CStep2: Bool = false
    @Published var actionW2CStep3: Bool = false
    @Published var actionC2CStep1: Bool = false
    @Published var actionC2CStep2: Bool = false
    @Published var actionC2WStep1: Bool = false
    @Published var actionC2WStep2: Bool = false
    @Published private var cardName: String = ""
    @Published private var password: String = ""
    @Published private var mnemonic: String = ""
    
    func getCardName() -> String {
        return cardName
    }
    
    func getPassword() -> String {
        return password
    }
    
    func getMnemonic() -> String {
        return mnemonic
    }
    
    func setCardName(_ newName: String) {
        cardName = newName
    }
    
    func setPassword(_ newPassword: String) {
        password = newPassword
    }
    
    func setMnemonic(_ newMnemonic: String) {
        mnemonic = newMnemonic
    }
    
    func clearData() {
        actionW2CStep1 = false
        actionW2CStep2 = false
        actionW2CStep3 = false
        actionC2CStep1 = false
        actionC2CStep2 = false
        actionC2WStep1 = false
        actionC2WStep2 = false

        cardName = ""
        password = ""
        mnemonic = ""
    }
}

struct CardInfo: Codable {
    var version: Int
    var name: String
    var data: String
}

struct JsonPackage {
    static func pack(cardInfo: CardInfo) -> String? {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(cardInfo) {
            let base64EncodedData = jsonData.base64EncodedData()
            if let base64String = String(data: base64EncodedData, encoding: .utf8) {
                return base64String
            }
        }
        return nil
    }
    
    static func unPack(from base64String: String) -> CardInfo? {
        if let base64Data = Data(base64Encoded: base64String) {
            let jsonDecoder = JSONDecoder()
            if let decodedCardInfo = try? jsonDecoder.decode(CardInfo.self, from: base64Data) {
                return decodedCardInfo
            }
        }
        return nil
    }
}
