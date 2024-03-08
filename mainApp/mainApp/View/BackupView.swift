//
//  BackupView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct BackupView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var dataBox: DataBox
    @State var isSuccess: Bool = false

    var body: some View {
        ZStack {
            VStack {
                PrimaryActionBlockNoBorderModel(textTitle: "LandingW2CTitle", textContent: "LandingW2CContent", image: AppImage.landingW2C)
                BackupActionView(toggle: $isSuccess)
            }
            .background {
                Image(AppImage.actionWallpaper)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            VStack {
                Spacer()

                Text("NfcWriteHint")
                    .font(AppFont.fontBody3)
                    .foregroundStyle(AppColor.textHint)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(width: 360)
            }
            
            if isSuccess {
                SuccessAlertModel(toggle: $isSuccess, content: "SuccessBackupContent") {
                    let inAppReviewAlert = InAppReviewAlert()
                    inAppReviewAlert.setIsAlert()
                    router.path = .init()
                }
                .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToobarBackButtonModel()
            }
        }
    }
}

struct BackupActionView: View {
    @EnvironmentObject var dataBox: DataBox
    var dataAlgorithm = DataAlgorithm()
    var nfcOperationsHandler = NfcOperationsHandler()
    @State var isEncryptSuccess: Bool = false
    @Binding var toggle: Bool
    @State var isActionFailed: Bool = false
    @State var isOpenGudieView: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if dataBox.actionW2CStep1 {
                NavigationBox(viewValue: PathInfo.backupViewSetMnemonicValue) {
                    SecondaryStepBlock(textStep: "ActionSTEP1", textTitle: "W2CStep1Title", textContent: "W2CStep1Content")
                }
            } else {
                NavigationBox(viewValue: PathInfo.backupViewSetMnemonicValue) {
                    PrimaryStepBlock(textStep: "ActionSTEP1", textTitle: "W2CStep1Title", textContent: "W2CStep1Content")
                }
            }
            if dataBox.actionW2CStep2 {
                NavigationBox(viewValue: PathInfo.backupViewSetPasswordValue) {
                    SecondaryStepBlock(textStep: "ActionSTEP2", textTitle: "W2CStep2Title", textContent: "W2CStep2Content")
                }
            } else {
                NavigationBox(viewValue: PathInfo.backupViewSetPasswordValue) {
                    PrimaryStepBlock(textStep: "ActionSTEP2", textTitle: "W2CStep2Title", textContent: "W2CStep2Content")
                }
            }
            
            VStack(alignment: .trailing, spacing: 5) {
                Button(action: {
                    var cipherText: String = ""
                    //var plainText: String = ""
                    (isEncryptSuccess, cipherText, _) = dataAlgorithm.action(cardName: dataBox.getCardName(), password: dataBox.getPassword(), words: dataBox.getMnemonic())
                    if isEncryptSuccess {
                        let cardInfo = CardInfo(version: 1, name: dataBox.getCardName(), data: cipherText)
                        if let data = JsonPackage.pack(cardInfo: cardInfo) {
                            if (nfcOperationsHandler.startNFCWriting(rawString: data)) {
                                withAnimation {
                                    toggle.toggle()
                                }
                                dataAlgorithm.clearData()
                            }
                        } else {
                            isActionFailed.toggle()
                        }
                    } else {
                        isActionFailed.toggle()
                    }
                }) {
                    PrimaryStepBlock(textStep: "ActionSTEP3", textTitle: "W2CStep3Title", textContent: "W2CStep3Content")
                }
                
                Button(action: {
                    isOpenGudieView.toggle()
                }) {
                    Text("W2CNoCard")
                        .font(AppFont.fontBody2)
                        .underline()
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(AppColor.textHint)
                        .padding(.horizontal)
                }
            }
            .opacity(dataBox.actionW2CStep1 && dataBox.actionW2CStep2 ? 1 : 0.4)
            .disabled(!(dataBox.actionW2CStep1 && dataBox.actionW2CStep2))

            Spacer()
        }
        .sheet(isPresented: $isOpenGudieView) {
            GuideView()
        }
        .alert(isPresented: $isActionFailed) {
            Alert(title: Text("BackupFailedTitle"), message: Text("BackupFailedContent"), dismissButton: .default(Text("DoneButton")))
        }
    }
}

struct bvSetMnemonicView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataBox: DataBox
    @ObservedObject private var viewModel = Bip39ValidatorViewModel()
    @State var isNoCollectDataAlert: Bool = false
    @FocusState private var isStartEditing: Bool

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                HStack {
                    Group {
                        Text("W2CStep1Title")
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
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("EnterMnemonic")
                        .font(AppFont.fontH4)
                        .foregroundStyle(AppColor.textHint)
                    
                    MnemonicFieldModel(primaryHint: "MnemonicHint", fieldValue: $viewModel.mnemonic, isDone: $viewModel.isValidMnemonic)
                        .focused($isStartEditing)
                        .onReceive(viewModel.$isValidMnemonic) { isValid in
                            if isValid {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                            }
                        }
                    
                    Button(action: {
                        dataBox.actionW2CStep1.toggle()
                        let words = viewModel.mnemonic.components(separatedBy: " ").filter { !$0.isEmpty }
                        dataBox.setMnemonic(words.joined(separator: " "))
                        dismiss()
                    }) {
                        SecondaryInteractiveButtonModel(text: "NextStepButton", isActive: $viewModel.isValidMnemonic)
                    }
                    .disabled(!viewModel.isValidMnemonic)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background {
            Image(AppImage.actionWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToobarBackButtonModel()
            }
            ToolbarItem(placement: .keyboard) {
                wordListSearchBar(input: $viewModel.mnemonic)
            }
        }
        .alert(isPresented: $isNoCollectDataAlert) {
            Alert(title: Text("NoCollectDataAlertTitle"), message: Text("NoCollectDataAlertContent"), dismissButton: .default(Text("GotItButton")))
        }
        .onAppear {
            isStartEditing.toggle()
            dataBox.actionW2CStep1 = viewModel.isValidMnemonic
        }
        .onDisappear {
            viewModel.clearData()
        }
    }
}

struct wordListSearchBar: View {
    @Binding var input: String
    @State private var matchingWords: [String] = []
    @State private var previousInput: String = ""

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(matchingWords.prefix(5), id: \.self) { word in
                    Button(action: {
                        if let researchWord = input.split(separator: " ").filter({ !$0.isEmpty }).last.map(String.init) {
                            let remainingCharacters = String(word.dropFirst(researchWord.count))
                            input += remainingCharacters + " "
                        }
                    }) {
                        WordListSearchButtonModel(text: word)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, -20)
        .scrollIndicators(.hidden)
        .onChange(of: input) { newValue in
            matchingWords.removeAll()
            let isForward = newValue.count > previousInput.count
            previousInput = newValue

            if let lastCharacter = newValue.last, lastCharacter.isLetter {
                guard let lastWord = newValue.split(separator: " ").filter({ !$0.isEmpty }).last.map(String.init) else {
                    return
                }
                
                matchingWords = findWordsStartingWith(prefix: lastWord)
                if matchingWords.count == 1 && isForward {
                    if let word = matchingWords.first {
                        if let researchWord = newValue.split(separator: " ").filter({ !$0.isEmpty }).last.map(String.init) {
                            let remainingCharacters = String(word.dropFirst(researchWord.count))
                            input += remainingCharacters + " "
                        }
                    }
                }
            }
        }
    }
    
    func findWordsStartingWith(prefix: String) -> [String] {
        var matchingWords = [String]()
        var count = 0

        for word in WordLists.english {
            if word.hasPrefix(prefix) {
                matchingWords.append(word)
                count += 1
            }
            
            if count >= 5 {
                break
            }
        }
        
        return matchingWords
    }
}

struct bvSetPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataBox: DataBox
    @ObservedObject private var viewModel = UserInfoViewModel()
    @State var isNoCollectDataAlert: Bool = false
    @FocusState private var isStartEditing: Bool

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Group {
                        Text("W2CStep2Title")
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
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("PasswordDescription")
                        .font(AppFont.fontH4)
                        .foregroundStyle(AppColor.textHint)
                    
                    PasswordFieldModel(titleName: "CreatePassword", fieldName: "", fieldValue: $viewModel.password, primaryHint: "PasswordHint", isDone: $viewModel.isPasswordPass)
                        .focused($isStartEditing)

                    PasswordFieldModel(titleName: "ConfirmPassword", fieldName: "", fieldValue: $viewModel.passwordConfirm, primaryHint: "ConfirmPasswordHint", isDone: $viewModel.isPasswordConfirmValid)
                    
                    Button(action: {
                        let randomName = String(format: "%04d", Int.random(in: 0...9999))
                        dataBox.setCardName(randomName)
                        dataBox.setPassword(viewModel.password)
                        dataBox.actionW2CStep2.toggle()
                        dismiss()
                    }) {
                        SecondaryInteractiveButtonModel(text: "NextStepButton", isActive: $viewModel.isPasswordConfirmValid)
                    }
                    .padding(.top, 5)
                    .disabled(!viewModel.isPasswordConfirmValid)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background {
            Image(AppImage.actionWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
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
        .onAppear{
            isStartEditing.toggle()
            dataBox.actionW2CStep2 = viewModel.isAllPass
        }
        .onDisappear {
            viewModel.clearData()
        }
    }
}

struct BVPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            BackupView()
            bvSetMnemonicView()
            bvSetPasswordView()
        }
        .environmentObject(DataBox())
        .preferredColorScheme(.dark)
    }
}
