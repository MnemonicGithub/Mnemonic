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
    @State var isUnPackFailed: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                dataBox.actionC2WStep1 = false
                if let answer = nfcOperationsHandler.startNFCReading() {
                    if let unpackedCardInfo: CardInfo = JsonPackage.unPack(from: answer) {
                        dataBox.actionC2WStep1 = true
                        dataBox.setCardName(unpackedCardInfo.name)
                        dataBox.setMnemonic(unpackedCardInfo.data)
                    } else {
                        isUnPackFailed.toggle()
                    }
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
        .alert(isPresented: $isUnPackFailed) {
            Alert(title: Text("JsonUpackFailedTitle"), message: Text("JsonUpackFailedContent"), dismissButton: .default(Text("DoneButton")))
        }
    }
}

struct rvShowMnemonicView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var dataBox: DataBox
    private var dataAlgorithm = DataAlgorithm()
    
    @State var isNoCollectDataAlert: Bool = false
    @State var isDecryptSuccess: Bool = false
    
    @FocusState private var isStartEditing: Bool
    @State var password: String = ""
    @State private var plainText: String = ""
    
    @State private var showCopyAlert: Bool = false
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    @State private var copyIcons: [UUID] = []
    @State private var timer: Timer?

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                HStack {
                    Group {
                        Text("C2WStep2Title")
                        Button {
                            isNoCollectDataAlert.toggle()
                        } label: {
                            Image(systemName: AppImage.noCollectDataAlert)
                        }
                    }
                    .foregroundStyle(AppColor.textPrimary)
                    .font(AppFont.fontH2)
                    .kerning(1)
                }
                
                VStack (alignment: .leading, spacing: 20) {
                    if isDecryptSuccess {
                        Text("NeverShareHint")
                            .font(AppFont.fontH4)
                            .foregroundStyle(AppColor.textHint)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ShowMnemonicModel(words: plainText)
                            
                            Button {
                                UIPasteboard.general.string = plainText
                                DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                                    UIPasteboard.general.string = ""
                                }
                                
                                impactFeedbackGenerator.impactOccurred()
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.2, blendDuration: 10)) {
                                    copyIcons.append(UUID())
                                }
                                
                                self.timer?.invalidate()
                                self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                    copyIcons.removeAll()
                                }
                            } label: {
                                CopyButtonModel(image: AppImage.copyToClipboard, title: "Copy for 60s")
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            router.path = .init()
                        }) {
                            SecondaryInteractiveButtonModel(text: "Finish", isActive: $isDecryptSuccess)
                        }
                    } else {
                        EnterPasswordModel(isVerify: $isDecryptSuccess, password: $password) {
                            withAnimation {
                                (isDecryptSuccess, plainText) = dataAlgorithm.toPlain(cardName: dataBox.getCardName(), password: password, cipherText: dataBox.getMnemonic())
                            }
                        }
                        .padding(.top, 10)
                        .focused($isStartEditing)
                        .zIndex(1)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background {
            Image(AppImage.actionWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .zIndex(1)

            ForEach(copyIcons, id: \.self) { ID in
                Image(systemName: AppImage.copyToClipboard)
                    .resizable()
                    .scaledToFit()
                    .frame(width: CGFloat.random(in: 10...30))
                    .foregroundStyle(Color.random)
                    .opacity(0.8)
                    .scaleEffect(1)
                    .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    .id(ID)
            }
            .zIndex(2)
        }
        .navigationBarBackButtonHidden(true)
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToobarBackButtonModel()
            }
        }
        .alert(isPresented: $isNoCollectDataAlert) {
            Alert(title: Text("NoCollectDataAlertTitle"), message: Text("NoCollectDataAlertContent"), dismissButton: .default(Text("GotItButton")))
        }
        .onAppear {
            isStartEditing.toggle()
            impactFeedbackGenerator.prepare()
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
            rvShowMnemonicView()
        }
        .environmentObject(DataBox())
        .preferredColorScheme(.dark)
    }
}



