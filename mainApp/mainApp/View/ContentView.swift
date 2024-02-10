//
//  ContentView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isReadTerms") var isReadTerms = false
    @State var isNeedUpadte: Bool = false
    @State var showLogo = true
    @State var isGetStarted: Bool = false

    var body: some View {
        ZStack {
            Image(AppImage.welcomeWallpaper)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    
                    Text("SloganFront")
                        .font(AppFont.fontH)
                        .foregroundColor(AppColor.textPrimary)
                                        
                    Text("SloganRear")
                        .font(AppFont.fontH)
                        .foregroundColor(AppColor.textPoint)
                    
                    Text("SloganDescription")
                        .font(AppFont.fontBody2)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Spacer()

                    ButtonBox(toggle: $isGetStarted) {
                        SecondaryButtonModel(text: "GetStarted")
                    }
                    
                    Spacer()
                }
            }
            
            if (!isReadTerms && !isNeedUpadte){
                TermsAlertModel(toggle: $isReadTerms)
                    .zIndex(1)
            }
            
            if isNeedUpadte {
                UpdateAlertModel(toggle: $isNeedUpadte)
                .zIndex(2)
            }
            
            if showLogo {
                LogoView()
                    .zIndex(3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLogo.toggle()
                            }
                        }
                    }
            }
        }
        .onAppear {
            // Check - Is the latest app version?
            
            
        }
        .fullScreenCover(isPresented: $isGetStarted) {
            LandingPageView()
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .environment(\.locale, .init(identifier: "en"))
 }
