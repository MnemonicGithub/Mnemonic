//
//  ContentView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isReadTerms") var isReadTerms = false
    @State var isNeedUpdate: Bool = false
    @State var showLogo = true
    @State var isGetStarted: Bool = false

    var body: some View {
        ZStack {
            VideoPlayerView(videoURL: Bundle.main.url(forResource: "LandingVideo", withExtension: "mp4")!)
                    .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("SloganFront")
                        .font(AppFont.fontH)
                        .foregroundStyle(AppColor.textPrimary)
                    
                    Text("SloganRear")
                        .font(AppFont.fontH)
                        .foregroundStyle(AppColor.textGradientPoint)
                }
                
                Text("SloganDescription")
                    .font(AppFont.fontBody2)
                    .foregroundStyle(AppColor.textPrimary)
                
                Spacer()

                ButtonBox(toggle: $isGetStarted) {
                    SecondaryButtonModel(text: "GetStarted")
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
            
            if (!isReadTerms && !isNeedUpdate){
                TermsAlertModel(toggle: $isReadTerms)
                    .zIndex(1)
            }
            
            if isNeedUpdate {
                UpdateAlertModel(toggle: $isNeedUpdate)
                .zIndex(2)
            }
            
            if showLogo {
                LogoView()
                    .zIndex(3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut) {
                                showLogo.toggle()
                            }
                        }
                    }
            }
        }
        .onAppear {
            let checkVersion = CheckVersion()
            checkVersion.isUpdate { updateAvailable in
                self.isNeedUpdate = updateAvailable
            }
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
