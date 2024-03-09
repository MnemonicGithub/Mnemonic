//
//  UIStyleMap.swift
//  mainApp
//
//  Created by Andy on 1/22/24.
//

import Foundation
import SwiftUI

// MARK: - Set Map

struct FontSet {
    static var Title36: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 36, weight: .bold, design: .rounded)
        } else {
            return .system(size: 36, weight: .medium, design: .rounded)
        }
    }
    
    static var Title28: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 28, weight: .bold, design: .rounded)
        } else {
            return .system(size: 28, weight: .medium, design: .rounded)
        }
    }
    
    static var Title24: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 24, weight: .bold, design: .rounded)
        } else {
            return .system(size: 24, weight: .medium, design: .rounded)
        }
    }
    
    static var Title22: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 22, weight: .bold, design: .rounded)
        } else {
            return .system(size: 22, weight: .medium, design: .rounded)
        }
    }
    
    static var Title16: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 16, weight: .bold, design: .rounded)
        } else {
            return .system(size: 16, weight: .medium, design: .rounded)
        }
    }
    
    static var Title14: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 14, weight: .bold, design: .rounded)
        } else {
            return .system(size: 14, weight: .medium, design: .rounded)
        }
    }
    
    static var Body16: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 16, weight: .semibold, design: .rounded)
        } else {
            return .system(size: 16, weight: .regular, design: .rounded)
        }
    }
    
    static var Body14: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 14, weight: .semibold, design: .rounded)
        } else {
            return .system(size: 14, weight: .regular, design: .rounded)
        }
    }
    
    static var Body12: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 12, weight: .regular, design: .rounded)
        } else {
            return .system(size: 12, weight: .thin, design: .rounded)
        }
    }
    
    static var Caption12: Font {
        if !UIAccessibility.isBoldTextEnabled {
            return .system(size: 12, weight: .bold, design: .rounded)
        } else {
            return .system(size: 12, weight: .medium, design: .rounded)
        }
    }
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

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    static var randomLight: Color {
        return Color(
            red: .random(in: 0.5...1),
            green: .random(in: 0.5...1),
            blue: .random(in: 0.5...1)
        )
    }
}

enum ColorSet {
    
    // Gradient Color
    static let gradientClear: LinearGradient = LinearGradient(colors: [ColorSet.clear, ColorSet.clear], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gradientWhite: LinearGradient = LinearGradient(colors: [ColorSet.white, ColorSet.white], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gradientLightGreen: LinearGradient =
    LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.87, green: 1, blue: 0.7), location: 0.01),
        Gradient.Stop(color: Color(red: 0.84, green: 0.98, blue: 0.47), location: 0.45),
        Gradient.Stop(color: Color(red: 0.82, green: 0.98, blue: 0.49), location: 0.50),
        Gradient.Stop(color: Color(red: 0.66, green: 0.96, blue: 0.71), location: 1.00),],
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    static let gradientNeutralGray: LinearGradient = LinearGradient(colors: [ColorSet.neutralGray, ColorSet.neutralGray], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gradientCharcoalGray: LinearGradient = LinearGradient(colors: [ColorSet.charcoalGray, ColorSet.charcoalGray], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gradientBlack: LinearGradient = LinearGradient(colors: [ColorSet.black, ColorSet.black], startPoint: .topLeading, endPoint: .bottomTrailing)

    // Color
    static let clear: Color = Color.clear
    static let white: Color = Color(.white)
    static let lightGreen: Color = Color(red: 0.84, green: 0.98, blue: 0.47)
    static let neutralGray: Color = Color(red: 0.59, green: 0.59, blue: 0.59)
    static let darkGray: Color = Color(red: 0.17, green: 0.17, blue: 0.17)
    static let charcoalGray: Color = Color(red: 0.11, green: 0.11, blue: 0.11)
    static let black: Color = Color(.black)
}

enum AppColor {
    
    // Dummy
    static let gradientDummy: LinearGradient = ColorSet.gradientClear
    static let ColorDummy: Color = ColorSet.clear
    
    // Text
    static let textPrimary: Color = ColorSet.white
    static let textSecondary: Color = ColorSet.black
    static let textPoint: Color = ColorSet.lightGreen
    static let textHint: Color = ColorSet.neutralGray
    static let textInactive: Color = ColorSet.darkGray
    static let textGradientPoint: LinearGradient = ColorSet.gradientLightGreen
    static let textGradientHint: LinearGradient = ColorSet.gradientNeutralGray

    // Border
    static let borderGradientPrimary: LinearGradient = ColorSet.gradientLightGreen
    static let borderGradientSecondary: LinearGradient = ColorSet.gradientNeutralGray
    static let borderButton: Color = ColorSet.darkGray
    
    // Icon
    static let iconGradientPrimary: LinearGradient = ColorSet.gradientLightGreen
    static let iconSecondary: Color = ColorSet.white
    
    // Background
    static let backgroundColor: Color = ColorSet.charcoalGray
    static let boxBackgroundColor: Color = ColorSet.darkGray
    static let buttonBackgroundGradientColor: LinearGradient = ColorSet.gradientLightGreen
}

// MARK: - Image Map

enum AppImage {
    
    // System Name
    static let navigationBack: String = "chevron.left"
    static let reviewStart: String = "star.fill"
    static let noCollectDataAlert: String = "lock.shield.fill"
    static let copyToClipboard: String = "doc.on.clipboard"
    static let buyMeCoffee: String = "heart.fill"
    static let contactUs: String = "envelope.circle"
    
    // Illustration
    static let inAppReview: String = "review_illustration"
    static let appUpdate: String = "update_illustration"
    static let readTerms: String = "terms_illustration"
    static let oops: String = "oops_illustration"
    static let success: String = "success_illustration"
    static let lock: String = "lock_illustration"
    static let landingWallpaper: String = "landing_illustration"
    static let landingW2C: String = "wc_icon"
    static let landingC2C: String = "cc_icon"
    static let landingC2W: String = "cw_icon"
    static let landingW2Cinverter: String = "wc_icon_inv"
    static let landingC2Cinverter: String = "cc_icon_inv"
    static let landingC2Winverter: String = "cw_icon_inv"
    
    // Icon
    static let guide: String = "guide"
    static let guidePageIcon: String = "guide_lightgreen"
    static let guidePageLine: String = "guide_dot"
    static let guidePage: String = "guide_background"
    static let aboutUs: String = "about_us"
    static let showPassword: String = "eye_open"
    static let hidePassword: String = "eye_close"
    
    // Wallpaper
    static let welcomeWallpaper: String = "welcome_page"
    static let actionWallpaper: String = "action_page"
    static let logoName: String = "logo_name"
    static let logoIcon: String = "logo"
    
    // About Us
    static let aboutLine1: String = "ch1_line"
    static let aboutLine2: String = "ch2_line"
    static let aboutLine3: String = "ch3_line"
    static let aboutIcon1: String = "ch1_icon"
    static let aboutIcon2: String = "ch2_icon"
    static let aboutIcon3: String = "ch3_icon"
    static let aboutQRcode: String = "address_qrcode"
    static let githubLogo: String = "github"
}
