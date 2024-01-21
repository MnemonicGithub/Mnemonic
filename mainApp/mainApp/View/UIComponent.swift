//
//  UIComponent.swift
//  mainApp
//
//  Created by Andy on 1/14/24.
//

import Foundation
import SwiftUI

// MARK: - Set Map

enum FontSet {
    static let Title36: Font = Font.custom("SF Pro", size: 36).weight(.bold)
    static let Title28: Font = Font.custom("SF Pro", size: 28).weight(.bold)
    static let Title24: Font = Font.custom("SF Pro", size: 24).weight(.bold)
    static let Title22: Font = Font.custom("SF Pro", size: 22).weight(.bold)
    static let Title16: Font = Font.custom("SF Pro", size: 16).weight(.semibold)
    static let Title14: Font = Font.custom("SF Pro", size: 14).weight(.bold)
    static let Body16: Font = Font.custom("SF Pro", size: 16).weight(.semibold)
    static let Body14: Font = Font.custom("SF Pro", size: 14).weight(.semibold)
    static let Body12: Font = Font.custom("SF Pro", size: 11)
    static let Caption12: Font = Font.custom("SF Pro", size: 12).weight(.bold)
}

enum AppFont {
    static let fontH: Font = FontSet.Title36
    static let fontH1: Font = FontSet.Title28
    static let fontH2: Font = FontSet.Title24
    static let fontH3: Font = FontSet.Title22
    static let fontH4: Font = FontSet.Title16
    static let fontH5: Font = FontSet.Title14
    static let fontBody1: Font = FontSet.Body16
    static let fontBody2: Font = FontSet.Body14
    static let fontBody3: Font = FontSet.Body12
    static let fontCaption: Font = FontSet.Caption12
}

enum ColorSet {
    static let gradientGreen =     
    LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.87, green: 1, blue: 0.7), location: 0.01),
        Gradient.Stop(color: Color(red: 0.84, green: 0.98, blue: 0.47), location: 0.45),
        Gradient.Stop(color: Color(red: 0.82, green: 0.98, blue: 0.49), location: 0.50),
        Gradient.Stop(color: Color(red: 0.66, green: 0.96, blue: 0.71), location: 1.00),],
        startPoint: UnitPoint(x: 0.42, y: -0.51),
        endPoint: UnitPoint(x: 0.58, y: 1.51))
    static let lightGreen = Color(red: 0.84, green: 0.98, blue: 0.47)
    static let darkGray = Color(red: 0.17, green: 0.17, blue: 0.17)
    static let black = Color(.black)
    static let white = Color(.white)
}

enum AppColor {
    static let gradientPrimary = ColorSet.gradientGreen
    static let borderPrimary = ColorSet.lightGreen
    static let borderSecondary = ColorSet.darkGray
    static let iconPrimary = ColorSet.lightGreen
    static let iconSecondary = ColorSet.white
    static let textPrimary = ColorSet.white
    static let textSecondary = ColorSet.black
}

// MARK: - Text Filed

struct PasswordFieldModel: View {
    var titleName: String = ""
    var fieldName: String = ""
    @Binding var fieldValue: String
    @State var isSecureToggle: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(titleName)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            HStack {
                if isSecureToggle {
                    TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                } else {
                    SecureFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
                }
                Button(action: {
                    isSecureToggle.toggle()
                }) {
                    Image(systemName: isSecureToggle ? "eye" : "eye.slash")
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
        }
        .padding(.horizontal, 27)
    }
}

struct NormalFieldModel: View {
    var titleName: String = ""
    var fieldName: String = ""
    @Binding var fieldValue: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            Text(titleName)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)

            HStack {
                TextFieldModel(fieldName: fieldName, fieldValue: $fieldValue)
            }
            .frame(height: 50, alignment: .leading)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .inset(by: 0.5)
                    .stroke(AppColor.borderPrimary, lineWidth: 1)
            )
        }
        .padding(.horizontal, 27)
    }
}

struct TextFieldModel: View {
    var fieldName: String = ""
    @Binding var fieldValue: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            TextField(fieldName, text: $fieldValue)
                .font(AppFont.fontH4)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
                .onChange(of: fieldValue) { newValue, _ in
                    fieldValue = String(newValue.prefix(16))
                }
        } else {
            TextField(fieldName, text: $fieldValue)
                .font(AppFont.fontH4)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
        }
    }
}

struct SecureFieldModel: View {
    var fieldName: String = ""
    @Binding var fieldValue: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            SecureField(fieldName, text: $fieldValue)
                .font(AppFont.fontH4)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
                .onChange(of: fieldValue) { newValue, _ in
                    fieldValue = String(newValue.prefix(16))
                }
        } else {
            SecureField(fieldName, text: $fieldValue)
                .font(AppFont.fontH4)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .accentColor(AppColor.borderPrimary)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
        }
    }
}

struct MnemonicFieldModel: View {
    @Binding var fieldValue: String
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            TextEditorModel(fieldValue: $fieldValue)
        }
        .frame(height: 200, alignment: .topLeading)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
            .inset(by: 0.51)
            .stroke(Color(red: 0.84, green: 0.98, blue: 0.47), lineWidth: 1.0115)
        )
        .padding(.horizontal)
    }
}

struct TextEditorModel: View {
    var fieldName = ""
    @Binding var fieldValue: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            TextEditor(text: $fieldValue)
                .font(AppFont.fontH3)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
                .onChange(of: fieldValue) { newValue, _ in
                    fieldValue = String(newValue.prefix(216))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
        } else {
            TextEditor(text: $fieldValue)
                .font(AppFont.fontH3)
                .foregroundColor(AppColor.textPrimary)
                .accentColor(AppColor.borderPrimary)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocapitalization(.none)
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
        }
    }
}


// MARK: - Model and Box

struct PrimaryButtonModel: View {
    let text: String
    
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
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH4)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 26)
            .padding(.vertical, 14)
            .background(Color.clear)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColor.borderSecondary, lineWidth: 1.5)
            )
    }
}

struct PrimaryButton2Model: View {
    let text: String
    
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
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppFont.fontH5)
            .foregroundColor(AppColor.textPrimary)
            .padding(.horizontal, 29)
            .padding(.vertical, 9)
            .background(Color.clear)
            .cornerRadius(13)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColor.borderSecondary, lineWidth: 1.5)
            )
    }
}

struct PrimaryButton3Model: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppFont.fontCaption)
            .foregroundColor(AppColor.textSecondary)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(AppColor.gradientPrimary)
            .cornerRadius(10)
    }
}

struct SecondaryButton3Model: View {
    let text: String
    
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
    let text: String
    
    var body: some View {
        Image(systemName: text)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(AppColor.iconSecondary)
            .padding(.vertical)
    }
}

struct PrimaryActionBlockModel: View {
    var textTitle: String = ""
    var textContent: String = ""
    var image: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
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
                .inset(by: 0.54)
                .stroke(AppColor.borderPrimary)
        )
        .padding(.horizontal)
    }
}

struct SecondaryActionBlockModel: View {
    var textTitle: String = ""
    var textContent: String = ""
    var image: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
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
    var textStep: String = ""
    var textTitle: String = ""
    var textContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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
                .inset(by: 0.54)
                .stroke(AppColor.borderPrimary)
        )
        .padding(.horizontal)
    }
}

struct SecondaryStepBlock: View {
    var textStep: String = ""
    var textTitle: String = ""
    var textContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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
                
                HStack {
                    Text(textContent)
                    .font(AppFont.fontBody3)
                    .foregroundColor(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)

                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .frame(width: 15, height: 15)
                        .foregroundColor(AppColor.textSecondary)
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

    var body: some View {
        Button(action: {
            toggle.toggle()
        }) {
            viewComponent()
        }
    }
}

struct NavigationBox<Content: View>: View {
    let viewValue: Int
    var viewComponent: () -> Content

    var body: some View {
        NavigationLink(value: viewValue) {
            viewComponent()
        }
    }
}

// MARK: - Text View

struct BlockView: View {
    var textTitle: String = "Word to Card"
    var textContent: String = "Backup your Recovery words\non the NFC card."
    var image: String = "wcUnPress"
    var textTitleA: String = "Enter Recovery Words"
    var textContentA: String = "Select all the correct 12 to 24 words \nfrom your recovery phrase,please list in order."

    var body: some View {
        PrimaryActionBlockModel(textTitle: textTitle, textContent: textContent, image: "wcUnPress")
        SecondaryActionBlockModel(textTitle: textTitle, textContent: textContent, image: "wcPress")
        PrimaryStepBlock(textStep: "STEP 1", textTitle: textTitleA, textContent: textContentA)
        SecondaryStepBlock(textStep: "STEP 1", textTitle: textTitleA, textContent: textContentA)
    }
}

struct DententView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .foregroundColor(Color.teal)
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .opacity(0.6)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .opacity(0.6)
                Rectangle()
                    .foregroundColor(Color.gray)
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .opacity(0.6)
            }
        }
        .presentationDetents([.fraction(0.2), .medium, .large])
        .presentationDragIndicator(.automatic)
    }
}

#Preview {
    BlockView()
        .preferredColorScheme(.dark)

}
