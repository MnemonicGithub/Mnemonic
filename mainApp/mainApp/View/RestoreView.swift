//
//  RestoreView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct RestoreView: View {
    @EnvironmentObject var dataBox: DataBox

    var body: some View {
        VStack {
            PrimaryActionBlockNoBorderModel(textTitle: "LandingC2WTitle", textContent: "LandingC2WContent", image: AppImage.landingC2W)
            RestoreActionView()
        }
        .background {
            Image(AppImage.actionWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToobarBackButtonModel()
            }
        }
    }
}

struct RestoreActionView: View {
    @EnvironmentObject var dataBox: DataBox
    private var nfcOperationsHandler = NfcOperationsHandler()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                if let answer = nfcOperationsHandler.startNFCReading() {
                    let parsingAnswer = answer.split(separator: "\0")
                    dataBox.actionC2WStep1 = true
                    dataBox.setCardName(String(parsingAnswer[0]))
                    dataBox.setMnemonic(String(parsingAnswer[1]))
                } else {
                    dataBox.actionC2WStep1 = false
                }
            }) {
                if dataBox.actionC2WStep1 {
                    SecondaryStepBlock(textStep: "ActionSTEP1", textTitle: "C2WStep1Title", textContent: "C2WStep1Content")
                } else {
                    PrimaryStepBlock(textStep: "ActionSTEP1", textTitle: "C2WStep1Title", textContent: "C2WStep1Content")
                }
            }
            
            NavigationBox(viewValue: PathInfo.restoreViewShowMnemonicValue) {
                PrimaryStepBlock(textStep: "ActionSTEP2", textTitle: "C2WStep2Title", textContent: "C2WStep2Content")
                    .opacity(dataBox.actionC2WStep1 ? 1 : 0.4)
            }
            .disabled(!dataBox.actionC2WStep1)
            
            Spacer()
        }
    }
}

//struct rvStartReadView: View {
//    var body: some View {
//        BackToRootButtonModel()
//    }
//}

struct rvShowMnemonicView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var dataBox: DataBox
    private var dataAlgorithm = DataAlgorithm()
    @State var isDone: Bool = false
    @State var isDecryptSuccess: Bool = false
    @State var password: String = ""
    @State private var plainText: String = ""

    var body: some View {
        ScrollView {
            if isDecryptSuccess {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        VStack {
                            NamePasswordBoxModel(name: dataBox.getCardName(), password: password)
                            MnemonicBoxModel(words: plainText)
                        }

                        Spacer()
                    }
                    Button(action: {
                        router.path = .init()
                    }) {
                        SecondaryInteractiveButtonModel(text: "Finish", isActive: $isDecryptSuccess)
                    }
                }
                .padding(.top, 30)
            } else {
                EnterPasswordModel(isVerify: $isDecryptSuccess, password: $password) {
                    withAnimation {
                        (isDecryptSuccess, plainText) = dataAlgorithm.toPlain(cardName: dataBox.getCardName(), password: password, cipherText: dataBox.getMnemonic())
                    }
                }
                .zIndex(1)
            }
        }
        .background {
            Image(AppImage.actionWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ToobarBackButtonModel(title: "C2WStep2Title")
            }
        }
        .onDisappear {
            dataAlgorithm.clearData()
        }
    }
}

struct RVPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            RestoreView()
//            rvStartReadView()
            rvShowMnemonicView()
        }
        .environmentObject(DataBox())
        .preferredColorScheme(.dark)
    }
}



