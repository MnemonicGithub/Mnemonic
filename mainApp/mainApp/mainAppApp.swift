//
//  mainAppApp.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI

@main
struct mainAppApp: App {
//    @Environment(\.scenePhase) private var scenePhase
//    @State private var isAppSwitcher: Bool = false
    @State private var showLogo = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .preferredColorScheme(.dark)
                
                if showLogo {
                    LogoView()
                        .zIndex(1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showLogo.toggle()
                                }
                            }
                        }
                }
            }
        }
//        .onChange(of: scenePhase) { newPhase in
//            switch newPhase {
//            case .background, .inactive:
//                print("True")
//            default:
//                print("false")
//            }
//        }
    }
}

struct LogoView: View {
    var body: some View {
        ZStack {
            AppColor.backgroundColor
                .ignoresSafeArea()
                .opacity(0.2)
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)
            
            Image(AppImage.logoIcon)
                .transition(.scale)
        }
    }
}

//struct AppSwitcherView: View {
//    var body: some View {
//        ZStack {
//            AppColor.gradientPrimary
//                .ignoresSafeArea()
//            Image("update_illustration")
//        }
//    }
//}

