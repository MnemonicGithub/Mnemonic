//
//  UIComponent.swift
//  mainApp
//
//  Created by Andy on 1/14/24.
//

import Foundation
import SwiftUI
import StoreKit
import AVKit
import AVFoundation

// MARK: - Text Filed

struct PasswordCheckFieldModel: View {
    var titleName: LocalizedStringKey
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    @State var isSecureToggle: Bool = false
    @Binding var isShake: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(titleName)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            VStack(alignment: .trailing, spacing: 5) {
                HStack {
                    if isSecureToggle {
                        TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                    } else {
                        SecureFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                    }
                    Button(action: {
                        isSecureToggle.toggle()
                    }) {
                        Image(isSecureToggle ? AppImage.showPassword : AppImage.hidePassword)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColor.iconSecondary)
                    }
                    .padding(.horizontal, 19)
                }
                .frame(height: 50, alignment: .leading)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(AppColor.borderPrimary, lineWidth: 1)
                )
                .modifier(ShakeEffect(shakes: isShake ? 1 : 0))
                .animation(driveAnimation, value: isShake)
            }
        }
        .padding(.horizontal)
    }
    
    private var driveAnimation: Animation {
        .linear
        .repeatCount(5, autoreverses: true)
        .speed(5)
    }
}

struct PasswordFieldModel: View {
    var titleName: LocalizedStringKey
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    var primaryHint: LocalizedStringKey
    @State var isSecureToggle: Bool = false
    @Binding var isDone: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(titleName)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textHint)
            VStack(alignment: .trailing, spacing: 5) {
                HStack {
                    if isSecureToggle {
                        TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                    } else {
                        SecureFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                    }
                    Button(action: {
                        isSecureToggle.toggle()
                    }) {
                        Image(isSecureToggle ? AppImage.showPassword : AppImage.hidePassword)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColor.iconSecondary)
                    }
                    .padding(.horizontal, 19)
                }
                .frame(height: 50, alignment: .leading)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(isDone ? AppColor.textHint : AppColor.textHint)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct NormalFieldModel: View {
    var titleName: LocalizedStringKey
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    var primaryHint: LocalizedStringKey
    @Binding var isDone: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(titleName)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textHint)

            VStack(alignment: .trailing, spacing: 5) {
                HStack {
                    TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                }
                .frame(height: 50, alignment: .leading)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(isDone ? AppColor.textHint : AppColor.textHint)
            }
        }
    }
}

struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: 5 * sin(position * 2 * .pi), y: 0))

    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct TextFieldModel: View {
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    
    var body: some View {
        TextField(fieldName, text: $fieldValue)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .padding(.horizontal)
            .keyboardType(.asciiCapable)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        
//        if #available(iOS 17.0, *) {
//            TextField(fieldName, text: $fieldValue)
//                .font(AppFont.fontH4)
//                .foregroundColor(AppColor.textPrimary)
//                .accentColor(AppColor.textPoint)
//                .padding(.horizontal)
//                .keyboardType(.asciiCapable)
//                .autocapitalization(.none)
//                .onChange(of: fieldValue) { newValue, _ in
//                    fieldValue = String(newValue.prefix(16))
//                }
//        }
    }
}

struct SecureFieldModel: View {
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    
    var body: some View {
        SecureField(fieldName, text: $fieldValue)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .padding(.horizontal)
            .keyboardType(.asciiCapable)
            .autocapitalization(.none)
            .disableAutocorrection(true)

//        if #available(iOS 17.0, *) {
//            SecureField(fieldName, text: $fieldValue)
//                .font(AppFont.fontH4)
//                .foregroundColor(AppColor.textPrimary)
//                .accentColor(AppColor.textPoint)
//                .padding(.horizontal)
//                .keyboardType(.asciiCapable)
//                .autocapitalization(.none)
//                .onChange(of: fieldValue) { newValue, _ in
//                    fieldValue = String(newValue.prefix(16))
//                }
//        }
    }
}

struct MnemonicFieldModel: View {
    var titleName: LocalizedStringKey
    var primaryHint: LocalizedStringKey
    @Binding var fieldValue: String
    @Binding var isDone: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(titleName)
                .font(AppFont.fontH4)
                .foregroundColor(AppColor.textHint)
            
            VStack(alignment: .trailing, spacing: 5) {
                HStack(alignment: .top, spacing: 10) {
                    TextEditorModel(fieldValue: $fieldValue)
                }
                .frame(height: 250, alignment: .topLeading)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(isDone ? AppColor.textHint : AppColor.textHint)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct TextEditorModel: View {
    @Binding var fieldValue: String
    
    var body: some View {
        TextEditor(text: $fieldValue)
            .font(AppFont.fontH3)
            .foregroundColor(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .keyboardType(.asciiCapable)
            .scrollContentBackground(.hidden)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        
//        TextField("", text: $fieldValue, axis: .vertical)
//            .font(AppFont.fontH3)
//            .foregroundColor(AppColor.textPrimary)
//            .accentColor(AppColor.textPoint)
//            .keyboardType(.asciiCapable)
//            .scrollContentBackground(.hidden)
//            .autocapitalization(.none)
//            .padding(.horizontal, 16)
//            .padding(.vertical, 18)

//        if #available(iOS 17.0, *) {
//            TextEditor(text: $fieldValue)
//                .font(AppFont.fontH3)
//                .foregroundColor(AppColor.textPrimary)
//                .accentColor(AppColor.borderPrimary)
//                .keyboardType(.asciiCapable)
//                .scrollContentBackground(.hidden)
//                .autocapitalization(.none)
//                .disableAutocorrection(true)
//                .onChange(of: fieldValue) { newValue, _ in
//                    fieldValue = String(newValue.prefix(216))
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 18)
//        }
    }
}

// MARK: - Show Box

struct NamePasswordBoxModel: View {
    var name: String = "andy"
    var password: String = "Have1Ncie7Day"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Card Name:")
                    .font(AppFont.fontH4)
                    .foregroundColor(AppColor.textPoint)
                    .frame(width: 90, alignment: .leading)
                Text(name)
                    .font(AppFont.fontH4)
                    .foregroundColor(AppColor.textPrimary)
                    .frame(width: 140, alignment: .leading)
            }
            
            HStack {
                Text("Password:")
                    .font(AppFont.fontH4)
                    .foregroundColor(AppColor.textPoint)
                    .frame(width: 90, alignment: .leading)
                Text(password)
                    .font(AppFont.fontH4)
                    .foregroundColor(AppColor.textPrimary)
                    .frame(width: 140, alignment: .leading)
            }
        }
        .frame(width: 320)
        .padding(.vertical, 15)
        .background(AppColor.boxBackgroundColor)
        .cornerRadius(25)
    }
}

struct MnemonicBoxModel: View {
    var words: String = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art"
//    var words: String = "zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo vote"

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(Array(pairWords.enumerated()), id: \.offset) { index, pair in
                HStack(spacing: 25) {
                    ForEach(pair.indices, id: \.self) { pairIndex in
                        HStack (spacing: 3){
                            Text("\(index * 2 + pairIndex + 1).")
                                .font(AppFont.fontH4)
                                .foregroundColor(AppColor.textPoint)
                                .frame(width: 30, alignment: .leading)
                            Text(pair[pairIndex])
                                .font(AppFont.fontH4)
                                .foregroundColor(AppColor.textPrimary)
                                .frame(width: 80, alignment: .leading)
                        }
                    }
                }
            }
        }
        .frame(width: 320)
        .padding(.vertical, 20)
        .background(AppColor.boxBackgroundColor)
        .cornerRadius(25)
    }
    
    private var pairWords: [[String]] {
        let allWords = words.components(separatedBy: " ")
        var pairs: [[String]] = []
        var pair: [String] = []
        
        for word in allWords {
            pair.append(word)
            if pair.count == 2 {
                pairs.append(pair)
                pair = []
            }
        }
        
        if !pair.isEmpty {
            pairs.append(pair)
        }
        
        return pairs
    }
}

// MARK: - Model and Box

struct SecondaryInteractiveButtonModel: View {
    let text: LocalizedStringKey
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(AppFont.fontH4)
                .foregroundColor(isActive ? AppColor.textSecondary : AppColor.textInactive)
                .padding(.horizontal, 26)
                .padding(.vertical, 14)
            Spacer()
        }
        .background(isActive ? AppColor.gradientPrimary : AppColor.gradientClear)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isActive ? Color.clear : AppColor.borderSecondary, lineWidth: 1.5)
        )
    }
}

struct PrimaryButtonModel: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textSecondary)
            .padding(.horizontal, 26)
            .padding(.vertical, 14)
            .background(AppColor.gradientPrimary)
            .cornerRadius(15)
    }
}

struct SecondaryButtonModel: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 26)
            .padding(.vertical, 14)
            .background(Color.clear)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(AppColor.borderSecondary, lineWidth: 1.5)
            )
    }
}

struct PrimaryButton2Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH5)
            .foregroundColor(AppColor.textSecondary)
            .padding(.horizontal, 29)
            .padding(.vertical, 9)
            .background(AppColor.gradientPrimary)
            .cornerRadius(13)
    }
}

struct SecondaryButton2Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH5)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 29)
            .padding(.vertical, 10)
            .background(Color.clear)
            .frame(minWidth: 160)
            .cornerRadius(13)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(AppColor.borderSecondary, lineWidth: 1.5)
            )
    }
}

struct PrimaryButton3Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontCaption)
            .foregroundColor(AppColor.textSecondary)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(AppColor.gradientPrimary)
            .frame(minWidth: 120)
            .cornerRadius(10)
    }
}

struct SecondaryButton3Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontCaption)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(Color.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColor.borderSecondary, lineWidth: 1.5)
            )
    }
}

struct PrimaryIconButtonModel: View {
    let image: String
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(AppColor.iconPrimary)
            .padding(.vertical)
    }
}

struct SecondaryIconButtonModel: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundColor(AppColor.iconSecondary)
            .padding(.vertical)
    }
}

struct PrimaryActionBlockModel: View {
    var textTitle: LocalizedStringKey
    var textContent: LocalizedStringKey
    var image: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                    .font(AppFont.fontH3)
                    .kerning(1)
                    .foregroundColor(AppColor.textPrimary)

                Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundColor(AppColor.textPrimary)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image(image)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(AppColor.borderPrimary, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct PrimaryActionBlockNoBorderModel: View {
    var textTitle: LocalizedStringKey
    var textContent: LocalizedStringKey
    var image: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                Text(textTitle)
                    .font(AppFont.fontH1)
                    .kerning(1)
                    .foregroundColor(AppColor.textPrimary)

                Text(textContent)
                    .font(AppFont.fontBody2)
                    .foregroundColor(AppColor.textPrimary)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image(image)
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
    }
}

struct SecondaryActionBlockModel: View {
    var textTitle: LocalizedStringKey
    var textContent: LocalizedStringKey
    var image: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                    .font(AppFont.fontH3)
                    .kerning(1)
                    .foregroundColor(AppColor.textSecondary)

                Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundColor(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image(image)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(AppColor.gradientPrimary)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct PrimaryStepBlock: View {
    var textStep: LocalizedStringKey
    var textTitle: LocalizedStringKey
    var textContent: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(textStep)
                    .font(AppFont.fontCaption)
                    .foregroundColor(AppColor.textSecondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .frame(width: 55, alignment: .center)
                    .background(AppColor.gradientPrimary)
                    .cornerRadius(10)
                
                Spacer()
                
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(AppColor.textPrimary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                    .font(AppFont.fontH3)
                    .kerning(1)
                    .foregroundColor(AppColor.textPrimary)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(textContent)
                        .font(AppFont.fontBody3)
                        .foregroundColor(AppColor.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .frame(width: 15, height: 15)
                        .foregroundColor(AppColor.textPrimary)
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(AppColor.borderPrimary, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct SecondaryStepBlock: View {
    var textStep: LocalizedStringKey
    var textTitle: LocalizedStringKey
    var textContent: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(textStep)
                    .font(AppFont.fontCaption)
                    .foregroundColor(AppColor.textPrimary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .frame(width: 55, alignment: .center)
                    .background(AppColor.textSecondary)
                    .cornerRadius(10)
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(AppColor.textSecondary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                .font(AppFont.fontH3)
                .kerning(1)
                .foregroundColor(AppColor.textSecondary)
                .multilineTextAlignment(.leading)
                
                HStack {
                    Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundColor(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)

                    Spacer()
                    
//                    Image(systemName: "chevron.right")
//                        .frame(width: 15, height: 15)
//                        .foregroundColor(AppColor.textSecondary)
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(AppColor.gradientPrimary)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct ButtonBox<Content: View>: View {
    @Binding var toggle: Bool
    var viewComponent: () -> Content
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        Button(action: {
            self.impactFeedbackGenerator.impactOccurred()
            toggle.toggle()
        }) {
            viewComponent()
        }
    }
}

struct NavigationBox<Content: View>: View {
    let viewValue: Int
    var viewComponent: () -> Content
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        NavigationLink(value: viewValue) {
            viewComponent()
        }
        .onAppear {
            impactFeedbackGenerator.prepare()
        }
        .simultaneousGesture(TapGesture().onEnded {
            self.impactFeedbackGenerator.impactOccurred()
        })
    }
}

// MARK: - Alert Set

struct LogoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
    
            Image(AppImage.welcomeWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.8)
                .zIndex(2)
            
            AppColor.backgroundColor
                .ignoresSafeArea()
                .opacity(0.2)
                .zIndex(3)
            
            Image(AppImage.logoIcon)
                .zIndex(4)
        }
    }
}

struct InAppReviewAlertModel: View {
    @Environment(\.requestReview) var requestReview
    @Binding var toggle: Bool
    let inAppReviewAlert = InAppReviewAlert()
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Image(AppImage.inAppReview)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 15) {
                    Text("InAppreviewTitle")
                        .font(AppFont.fontH2)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Text("InAppreviewContent")
                        .font(AppFont.fontBody2)
                        .foregroundColor(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(0..<5) { _ in
                            Image(systemName: AppImage.reviewStart)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(AppColor.iconPrimary)
                                .padding(.vertical)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                toggle.toggle()
                            }
                        }) {
                            SecondaryButton2Model(text: "NotNow")
                        }
                        
                        Button(action: {
                            withAnimation {
                                toggle.toggle()
                                presentReview()
                            }                        }) {
                            SecondaryButton2Model(text: "InAppreviewButton")
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
        .onDisappear {
            inAppReviewAlert.closeIsAlert()
        }
    }
    
    private func presentReview() {
        Task {
            // Delay for two seconds to avoid interrupting the person using the app.
            try await Task.sleep(for: .seconds(1))
            await requestReview()
            inAppReviewAlert.setIsRate()
        }
    }
}

struct UpdateAlertModel: View {
    @Binding var toggle: Bool
    let websiteURL = URL(string: AppLink.appStore)!
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(AppImage.appUpdate)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 15) {
                    Text("UpdateTitle")
                        .font(AppFont.fontH)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Text("UpdateContent")
                        .font(AppFont.fontBody2)
                        .foregroundColor(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        UIApplication.shared.open(websiteURL)
                    }) {
                        SecondaryButton2Model(text: "UpdateButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
    }
}

struct TermsAlertModel: View {
    @Binding var toggle: Bool
    let websiteURL = URL(string: AppLink.termsOfUse)!
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(AppImage.readTerms)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 15) {

                    Button(action: {
                        UIApplication.shared.open(websiteURL)
                    }) {
                        Text("\(Text("BeforeTermsOfUse")) \(Text("TermsOfUse").foregroundColor(AppColor.textPoint)) \(Text("AfterTermsOfUse"))")
                            .font(AppFont.fontBody1)
                            .foregroundColor(AppColor.textHint)
                            .multilineTextAlignment(.center)
                    }

                    Button(action: {
                        withAnimation(.easeInOut) {
                            toggle.toggle()
                        }
                    }) {
                        SecondaryButton2Model(text: "TermsButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
    }
}

struct OopsAlertModel: View {
    @Binding var toggle: Bool
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(AppImage.oops)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 15) {
                    Text("OopsTitle")
                        .font(AppFont.fontH)
                        .foregroundColor(AppColor.textPrimary)
                    Text("\(Text("OopsContent"))\n\(Text("OopsHint").foregroundColor(AppColor.textPoint))")
                        .font(AppFont.fontBody2)
                        .foregroundColor(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            toggle.toggle()
                        }
                        action?()
                    }) {
                        SecondaryButton2Model(text: "OopsButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
    }
}

struct SuccessAlertModel: View {
    @Binding var toggle: Bool
    var content: LocalizedStringKey
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(AppImage.success)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 15) {
                    Text("SuccessTitle")
                        .font(AppFont.fontH)
                        .foregroundColor(AppColor.textPrimary)
                    Text(content)
                        .font(AppFont.fontBody2)
                        .foregroundColor(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            toggle.toggle()
                        }
                        action?()
                    }) {
                        SecondaryButton2Model(text: "SuccessButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
    }
}

struct EnterPasswordModel: View {
    @Binding var isVerify: Bool
    @Binding var password: String
    @State var shouldShake: Bool = false
    var action: () -> Void
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    var body: some View {
        ZStack {

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(AppImage.readTerms)
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 30) {
                    PasswordCheckFieldModel(titleName: "", fieldName: "VerifyPasswordHint", fieldValue: $password, isShake: $shouldShake)
                    Button(action: {
                        action()
                        if !isVerify {
                            self.impactFeedbackGenerator.impactOccurred()
                            shouldShake.toggle()
                            password = ""
                        }
                    }) {
                        SecondaryButton2Model(text: "DecryptButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .cornerRadius(15)
            .padding()
        }
    }
}
// MARK: - Environment Set

struct SetBackground<Content: View>: View {
    var view: () -> Content

    var body: some View {
        ZStack {
            AppColor.backgroundColor
                .ignoresSafeArea()
            view()
        }
    }
}

struct ToobarBackButtonModel: View {
    @Environment(\.dismiss) var dismiss
    var title: LocalizedStringKey = ""
    var action: (() -> Void)?
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        HStack {
            Button(action: {
                action?()
                impactFeedbackGenerator.impactOccurred()
                dismiss()
            }) {
                Image(systemName: AppImage.navigationBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(AppColor.iconPrimary)
                    .padding(.vertical)
            }
            
            Text(title)
                .foregroundColor(AppColor.textPrimary)
                .font(AppFont.fontH3)
                .kerning(1)
        }
        .onAppear {
            impactFeedbackGenerator.prepare()
        }
    }
}

struct WordListSearchButtonModel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppFont.fontBody1)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.clear)
            .cornerRadius(13)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(AppColor.borderThirdary, lineWidth: 1.5)
                    .opacity(0.6)
            )
    }
}

struct BackToRootButtonModel: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
                //router.path.removeLast()
            }
        }
    }
}

// MARK: - Video View

struct VideoPlayerView: UIViewControllerRepresentable {
    var videoURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false

        // Set AVAudioSession category to ambient
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play()
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the view controller if needed
    }
}

// MARK: - Test View

struct TestView: View {
    @State var toggle: Bool = false
//    var body: some View {
//        VideoPlayerView(videoURL: Bundle.main.url(forResource: "LandingVideo", withExtension: "mp4")!)
//            .edgesIgnoringSafeArea(.all)
//    }
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                Button {
                    
                } label: {
                    WordListSearchButtonModel(text: "gooday")
                }
                
                Button {
                    
                } label: {
                    WordListSearchButtonModel(text: "abandon")
                }
                
                Button {
                    
                } label: {
                    WordListSearchButtonModel(text: "about")
                }
                
                Button {
                    
                } label: {
                    WordListSearchButtonModel(text: "art")
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    Group {
        TestView()
    }
        .preferredColorScheme(.dark)

}
