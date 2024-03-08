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
    static let appStore: String = "https://apps.apple.com/app/id6479014055"
    static let termsOfUse: String = "https://github.com/MnemonicGithub/Mnemonic/blob/master/TERMS%20OF%20USE.pdf"
    static let contactUs: String = "https://github.com/MnemonicGithub/Mnemonic/blob/master/README.md"
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
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }
    
    static func unPack(from jsonString: String) -> CardInfo? {
        if let jsonData = jsonString.data(using: .utf8) {
            let jsonDecoder = JSONDecoder()
            if let decodedCardInfo = try? jsonDecoder.decode(CardInfo.self, from: jsonData) {
                return decodedCardInfo
            }
        }
        return nil
    }
}

struct CheckVersion {
    func getAppStoreVersion(completion: @escaping (String?) -> Void) {
        let bundleId = "Mnemonic.mainApplication"
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleId)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let appStoreVersion = results.first?["version"] as? String {
                    completion(appStoreVersion)
                    return
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
            completion(nil)
        }
        
        task.resume()
    }

    func isUpdate(completion: @escaping (Bool) -> Void) {
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        
        getAppStoreVersion { appStoreVersion in
            guard let appStoreVersion = appStoreVersion else {
                print("Failed to retrieve App Store version.")
                completion(false)
                return
            }
            
            if bundleVersion != appStoreVersion {
                print("A newer version (\(appStoreVersion)) is available on the App Store.")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

