//
//  BackupView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct BackupView: View {
    @EnvironmentObject var dataBox: DataBox

    var body: some View {
        VStack {
            PrimaryActionBlockNoBorderModel(textTitle: "LandingW2CTitle", textContent: "LandingW2CContent", image: AppImage.landingW2C)
            BackupActionView()
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

struct BackupActionView: View {
    @EnvironmentObject var dataBox: DataBox

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
            
            NavigationBox(viewValue: PathInfo.backupViewStartBackup) {
                PrimaryStepBlock(textStep: "ActionSTEP3", textTitle: "W2CStep3Title", textContent: "W2CStep3Content")
                    .opacity(dataBox.actionW2CStep1 && dataBox.actionW2CStep2 ? 1 : 0.4)
            }
            .disabled(!(dataBox.actionW2CStep1 && dataBox.actionW2CStep2))
            
            Spacer()
        }
    }
}

struct bvSetMnemonicView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataBox: DataBox
    @ObservedObject private var viewModel = Bip39ValidatorViewModel()
    @State var isNoCollectDataAlert: Bool = false

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
                    .foregroundColor(AppColor.textPrimary)
                    .font(AppFont.fontH2)
                    .kerning(1)
                }
                
                VStack(alignment: .center, spacing: 20) {
                    MnemonicFieldModel(titleName: "EnterMnemonic", primaryHint: "MnemonicHint", fieldValue: $viewModel.mnemonic, isDone: $viewModel.isValidMnemonic)
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
                        SecondaryInteractiveButtonModel(text: "NextStep", isActive: $viewModel.isValidMnemonic)
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
            Alert(title: Text("NoCollectDataAlertTitle"), message: Text("NoCollectDataAlertContent"), dismissButton: .default(Text("GotIt")))
        }
        .onAppear {
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

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(matchingWords.prefix(5), id: \.self) { word in
                    Button(action: {
                        if let researchWord = input.split(separator: " ").filter({ !$0.isEmpty }).last.map(String.init) {
                            let remainingCharacters = String(word.dropFirst(researchWord.count))
                            if remainingCharacters == "" {
                                input += word + " "
                            } else {
                                input += remainingCharacters + " "
                            }
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
            guard let lastWord = newValue.split(separator: " ").filter({ !$0.isEmpty }).last.map(String.init) else {
                return
            }
            matchingWords = findWordsStartingWith(prefix: lastWord)
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

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                Text("W2CStep2Title")
                    .foregroundColor(AppColor.textPrimary)
                    .font(AppFont.fontH2)
                    .kerning(1)
                
                VStack(alignment: .leading, spacing: 15) {
                    NormalFieldModel(titleName: "SetCardName", fieldName: "", fieldValue: $viewModel.cardname, primaryHint: "CardNameHint", isDone: $viewModel.isCardnamePass)
                    PasswordFieldModel(titleName: "SetPassword", fieldName: "", fieldValue: $viewModel.password, primaryHint: "PasswordHint", isDone: $viewModel.isPasswordPass)
                    PasswordFieldModel(titleName: "ConfirmPassword", fieldName: "", fieldValue: $viewModel.passwordConfirm, primaryHint: "ConfirmPasswordHint", isDone: $viewModel.isPasswordConfirmValid)
                    
                    Button(action: {
                        dataBox.setCardName(viewModel.cardname)
                        dataBox.setPassword(viewModel.password)
                        dataBox.actionW2CStep2.toggle()
                        dismiss()
                    }) {
                        SecondaryInteractiveButtonModel(text: "NextStep", isActive: $viewModel.isAllPass)
                    }
                    .padding(.top, 5)
                    .disabled(!viewModel.isAllPass)
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToobarBackButtonModel()
            }
        }
        .onAppear{
            dataBox.actionW2CStep2 = viewModel.isAllPass
        }
        .onDisappear {
            viewModel.clearData()
        }
    }
}

struct bvStartBackView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var dataBox: DataBox
    private var dataAlgorithm = DataAlgorithm()
    private var nfcOperationsHandler = NfcOperationsHandler()
    @State var isEncryptSuccess: Bool = false
    @State private var cipherText: String = ""
    @State private var plainText: String = ""
    @State var isOops: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 5){
                    Text("W2CStep3Title")
                        .foregroundColor(AppColor.textPrimary)
                        .font(AppFont.fontH2)
                        .kerning(1)
                        .padding(.horizontal)
                    
                    if isEncryptSuccess {
                        VStack(alignment: .leading, spacing: 30) {
                            HStack(alignment: .center) {
                                Spacer()
                                
                                VStack {
                                    NamePasswordBoxModel(name: dataBox.getCardName(), password: dataBox.getPassword())
                                    MnemonicBoxModel(words: plainText)
                                }
                                
                                Spacer()
                            }
                            
                            Button(action: {
                                let combineString = dataBox.getCardName() + "\0" + cipherText
                                if (nfcOperationsHandler.startNFCWriting(rawString: combineString)) {
                                    withAnimation {
                                        isSuccess.toggle()
                                    }
                                }
                            }) {
                                SecondaryInteractiveButtonModel(text: "StartBackup", isActive: $isEncryptSuccess)
                            }
                        }
                    }
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
                    ToobarBackButtonModel()
                }
            }
            .onAppear {
                (isEncryptSuccess, cipherText, plainText) = dataAlgorithm.action(cardName: dataBox.getCardName(), password: dataBox.getPassword(), words: dataBox.getMnemonic())
                
                if !isEncryptSuccess {
                    isOops.toggle()
                }
            }
            .onDisappear {
                dataAlgorithm.clearData()
            }
            
            if isOops {
                OopsAlertModel(toggle: $isOops) {
                    router.path.removeLast()
                }
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
    }
}

struct BVPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            BackupView()
            bvSetMnemonicView()
            bvSetPasswordView()
            bvStartBackView()
        }
        .environmentObject(DataBox())
        .preferredColorScheme(.dark)
    }
}
