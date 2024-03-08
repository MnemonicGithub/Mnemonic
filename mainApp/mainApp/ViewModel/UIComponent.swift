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
            if titleName != "" {
                Text(titleName)
                .font(AppFont.fontH4)
                .foregroundStyle(AppColor.textHint)
            }

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
                            .foregroundStyle(AppColor.iconSecondary)
                    }
                    .padding(.horizontal, 19)
                }
                .frame(height: 50, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 5))
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
            .foregroundStyle(AppColor.textHint)
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
                            .foregroundStyle(AppColor.iconSecondary)
                    }
                    .padding(.horizontal, 19)
                }
                .frame(height: 50, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(isDone ? AppColor.textHint : AppColor.textHint)
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
            .foregroundStyle(AppColor.textHint)

            VStack(alignment: .trailing, spacing: 5) {
                HStack {
                    TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                }
                .frame(height: 50, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(isDone ? AppColor.textHint : AppColor.textHint)
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
            .foregroundStyle(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .padding(.horizontal)
            .keyboardType(.asciiCapable)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textContentType(.oneTimeCode)
    }
}

struct SecureFieldModel: View {
    var fieldName: LocalizedStringKey
    @Binding var fieldValue: String
    
    var body: some View {
        SecureField(fieldName, text: $fieldValue)
            .font(AppFont.fontH4)
            .foregroundStyle(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .padding(.horizontal)
            .keyboardType(.asciiCapable)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textContentType(.oneTimeCode)
    }
}

struct MnemonicFieldModel: View {
    var primaryHint: LocalizedStringKey
    @Binding var fieldValue: String
    @Binding var isDone: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .trailing, spacing: 5) {
                HStack(alignment: .top, spacing: 10) {
                    TextEditorModel(fieldValue: $fieldValue)
                }
                .frame(height: 200, alignment: .topLeading)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(isDone ? AppColor.borderThirdary : AppColor.borderPrimary, lineWidth: 1)
                )
                
                Text(primaryHint)
                    .font(AppFont.fontBody3)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(isDone ? AppColor.textHint : AppColor.textHint)
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
            .foregroundStyle(AppColor.textPrimary)
            .accentColor(AppColor.textPoint)
            .keyboardType(.asciiCapable)
            .scrollContentBackground(.hidden)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
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
                .foregroundStyle(isActive ? AppColor.textSecondary : AppColor.textInactive)
                .padding(.horizontal, 26)
                .padding(.vertical, 14)
            Spacer()
        }
        .background(isActive ? AppColor.gradientPrimary : AppColor.gradientClear)
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
            .foregroundStyle(AppColor.textSecondary)
            .padding(.horizontal, 26)
            .padding(.vertical, 14)
            .background(AppColor.gradientPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct SecondaryButtonModel: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH4)
            .foregroundStyle(AppColor.textPrimary)
            .padding(.horizontal, 26)
            .padding(.vertical, 14)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
            .foregroundStyle(AppColor.textSecondary)
            .padding(.horizontal, 29)
            .padding(.vertical, 9)
            .background(AppColor.gradientPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}

struct SecondaryButton2Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH5)
            .foregroundStyle(AppColor.textPrimary)
            .padding(.horizontal, 29)
            .padding(.vertical, 10)
            .background(Color.clear)
            .frame(minWidth: 160)
            .clipShape(RoundedRectangle(cornerRadius: 13))
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
            .foregroundStyle(AppColor.textSecondary)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(AppColor.gradientPrimary)
            .frame(minWidth: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SecondaryButton3Model: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(AppFont.fontCaption)
            .foregroundStyle(AppColor.textPrimary)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
            .foregroundStyle(AppColor.iconPrimary)
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
            .foregroundStyle(AppColor.iconSecondary)
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
                    .foregroundStyle(AppColor.textPrimary)

                Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundStyle(AppColor.textPrimary)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image(image)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                    .foregroundStyle(AppColor.textPrimary)

                Text(textContent)
                    .font(AppFont.fontBody2)
                    .foregroundStyle(AppColor.textPrimary)
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
                    .foregroundStyle(AppColor.textSecondary)

                Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundStyle(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image(image)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(AppColor.gradientPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                    .foregroundStyle(AppColor.textSecondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .frame(width: 55, alignment: .center)
                    .background(AppColor.gradientPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Spacer()
                
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(AppColor.textPrimary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                    .font(AppFont.fontH3)
                    .kerning(1)
                    .foregroundStyle(AppColor.textPrimary)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(textContent)
                        .font(AppFont.fontBody3)
                        .foregroundStyle(AppColor.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .frame(width: 15, height: 15)
                        .foregroundStyle(AppColor.textPrimary)
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                    .foregroundStyle(AppColor.textPrimary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .frame(width: 55, alignment: .center)
                    .background(AppColor.textSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(AppColor.textSecondary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(textTitle)
                .font(AppFont.fontH3)
                .kerning(1)
                .foregroundStyle(AppColor.textSecondary)
                .multilineTextAlignment(.leading)
                
                HStack {
                    Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundStyle(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)

                    Spacer()
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(AppColor.gradientPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                        .foregroundStyle(AppColor.textPrimary)
                    
                    Text("InAppreviewContent")
                        .font(AppFont.fontBody2)
                        .foregroundStyle(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(0..<5) { _ in
                            Image(systemName: AppImage.reviewStart)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(AppColor.iconPrimary)
                                .padding(.vertical)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                toggle.toggle()
                            }
                        }) {
                            SecondaryButton2Model(text: "NotNowButton")
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
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
                        .foregroundStyle(AppColor.textPrimary)
                    
                    Text("UpdateContent")
                        .font(AppFont.fontBody2)
                        .foregroundStyle(AppColor.textHint)
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
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
                            .foregroundStyle(AppColor.textHint)
                            .multilineTextAlignment(.center)
                    }

                    Button(action: {
                        withAnimation {
                            toggle.toggle()
                        }
                    }) {
                        SecondaryButton2Model(text: "TermsButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
                        .foregroundStyle(AppColor.textPrimary)
                    Text("\(Text("OopsContent"))\n\(Text("OopsHint").foregroundColor(AppColor.textPoint))")
                        .font(AppFont.fontBody2)
                        .foregroundStyle(AppColor.textHint)
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
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
                        .foregroundStyle(AppColor.textPrimary)
                    Text(content)
                        .font(AppFont.fontBody2)
                        .foregroundStyle(AppColor.textHint)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            toggle.toggle()
                        }
                        action?()
                    }) {
                        SecondaryButton2Model(text: "DoneButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            .background(AppColor.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
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
    let passwordCount: Int = 8

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Image(AppImage.lock)
                Spacer()
            }
            .padding(.top, 20)
            
            VStack(alignment: .center, spacing: 20) {
                VStack (alignment: .center, spacing: 10){
                    Text("EnterPasswordDescription")
                        .font(AppFont.fontBody2)
                        .foregroundStyle(AppColor.textHint)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    PasswordCheckFieldModel(titleName: "", fieldName: "", fieldValue: $password, isShake: $shouldShake)
                }
                
                Button(action: {
                    action()
                    if !isVerify {
                        self.impactFeedbackGenerator.impactOccurred()
                        shouldShake.toggle()
                        password = ""
                    }
                }) {
                    SecondaryButton2Model(text: "DecryptButton")
                        .opacity(!(password.count < passwordCount) ? 1 : 0.3)
                }
                .padding(.bottom, 20)
                .disabled(password.count < passwordCount)
            }
        }
        .background(AppColor.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
}
// MARK: - Environment Set

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
                    .foregroundStyle(AppColor.iconPrimary)
                    .padding(.vertical)
            }
            
            Text(title)
                .foregroundStyle(AppColor.textPrimary)
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
            .foregroundStyle(AppColor.textPrimary)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 13))
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

struct CopyButtonModel: View {
    let image: String
    let title: LocalizedStringKey
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(title)
        }
        .font(AppFont.fontCaption)
        .foregroundStyle(AppColor.gradientPrimary)
        .frame(height: 40)
        .padding(.horizontal, 25)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(AppColor.borderSecondary, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct AnimationButtonModel: View {
    let image: String
    let title: LocalizedStringKey
    @Binding var toggle: Bool
    @State private var progress: Double = 0.0
    @State private var startTime: Date?
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                Text(title)
            }
            .font(AppFont.fontCaption)
            .foregroundStyle(AppColor.gradientPrimary)
            .frame(height: 40)
            .padding(.horizontal, 25)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(AppColor.borderSecondary, lineWidth: 2)
                    .background(
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 0)
                                .fill(AppColor.gradientPrimary)
                                .frame(width: geometry.size.width * CGFloat(progress), height: 5)
                                .padding(.top, 35)
                        }
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if startTime == nil {
                            startTime = Date()
                            startFilling()
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            timer?.invalidate()
                            timer = nil
                            startTime = nil
                            progress = 0.0
                        }
                    }
            )
        }
    }

    func startFilling() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let startTime = startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                withAnimation {
                    progress = min(elapsedTime / 0.5, 1.0)
                }
                if progress >= 1.0 {
                    timer?.invalidate()
                    timer = nil
                    toggle.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            progress = 0.0
                        }
                    }
                }
            }
        }
    }
}

struct WordCaseModel: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack (alignment: .center, spacing: 5) {
            Text(number)
                .font(AppFont.fontCaption)
                .foregroundStyle(AppColor.textHint)
                .frame(width: 20)

            Text(text)
                .font(AppFont.fontH4)
                .foregroundStyle(AppColor.gradientPrimary)
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .padding(.top, 7)
        .padding(.bottom, 9)
        .background(AppColor.boxBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct ShowMnemonicModel: View {
    var words: String
    @State private var wordArray: [String] = []
    var body: some View {
            OverflowGrid(horizontalSpacing: 10) {
                ForEach(Array(wordArray.enumerated()), id: \.offset) { (index, word) in
                    let count = String(format: "%02d", index + 1)
                    WordCaseModel(number: count, text: word)
                }
            }
            .onAppear {
                self.wordArray = self.words.components(separatedBy: " ").filter { !$0.isEmpty }
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

// MARK: - Fix Hide navigation bar button without losing swipe back gesture in SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

// MARK: - Replaces the issue that LazyVstack cannot automatically wrap lines  in SwiftUI

public struct OverflowGrid: Layout {
    private var horizontalSpacing: CGFloat
    private var verticalSpacing: CGFloat
    public init(horizontalSpacing: CGFloat, verticalSpacing: CGFloat? = nil) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing ?? horizontalSpacing
    }

    private struct RowSize {
        let width: CGFloat
        let height: CGFloat

        static let empty = RowSize(width: CGFloat(0), height: CGFloat(0))
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = generateRowSizes(subviews: subviews, proposal: proposal)
        let rowCount = CGFloat(rows.count)
        let combinedHeights: CGFloat = rows.reduce(CGFloat(0)) { acc, rowSize in
            return acc + rowSize.height
        }
        let calculatedSize = CGSize(width: rows.max(by: { $0.width < $1.width })?.width ?? 0,
                                    height:  combinedHeights + ((rowCount - 1) * verticalSpacing))
        return calculatedSize
    }

    private func generateRowSizes(subviews: Subviews, proposal: ProposedViewSize) -> [RowSize] {
        var rows = [RowSize.empty]
        for subview in subviews {
            let rowIndex = rows.count - 1
            let currentRowSize = rows.last ?? .empty
            let subviewSize = subview.dimensions(in: proposal)
            let subviewWidth = subviewSize.width
            let subviewHeight = subviewSize.height

            // Prevent creating infinite rows if the proposed width is smaller than any subview width.
            if currentRowSize.width == 0 {
                rows[rowIndex] = RowSize(width: subviewWidth,
                                         height: max(currentRowSize.height, subviewHeight))
            } else {
                let currentRowWidth = currentRowSize.width
                let newWidth = currentRowWidth + horizontalSpacing + subviewWidth
                let viewWillFit = newWidth <= (proposal.width ?? 0)
                if viewWillFit {
                    rows[rowIndex] = RowSize(width: newWidth, height: max(currentRowSize.height, subviewHeight))
                } else {
                    rows.append(RowSize(width: subviewWidth, height: subviewHeight))
                }
            }
        }
        return rows
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = generateRowSizes(subviews: subviews, proposal: proposal)
        var rowIndex = 0
        let boundsMinX = bounds.minX
        let boundsEnd = boundsMinX + bounds.width
        var x = boundsMinX
        var y = bounds.minY
        for subview in subviews {
            let subviewSize = subview.dimensions(in: proposal)
            let isFirstElementInRow = x == boundsMinX
            var elementStart = isFirstElementInRow ? x : x + horizontalSpacing
            var elementEnd = elementStart + subviewSize.width
            if elementEnd > boundsEnd && !isFirstElementInRow {
                elementStart = boundsMinX
                elementEnd = elementStart + subviewSize.width
                x = boundsMinX
                y += rows[rowIndex].height + verticalSpacing
                rowIndex += 1
            }
            let subviewCenter = CGPoint(x: elementStart + subviewSize.width / 2, y: y + subviewSize.height / 2)
            subview.place(
                at: subviewCenter,
                anchor: .center,
                proposal: ProposedViewSize(width: subviewSize.width,
                                           height: subviewSize.height))
            x = elementEnd
        }
    }
}

// MARK: - Preview

#Preview {
    Group {
        ShowMnemonicModel(words: "clay absent correct dragon tumble girl ecology tag method panic such doll slice apple miss exit luxury amateur awkward card settle crowd nephew cruel")
    }
        .preferredColorScheme(.dark)
}
