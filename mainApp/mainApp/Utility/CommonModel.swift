//
//  CommonModel.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

enum AppLink {
    static let appStore: String = "https://apps.apple.com/tw/app/safari/id1146562112"
    static let termsOfUse: String = "https://github.com/MnemonicGithub/Mnemonic"
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


