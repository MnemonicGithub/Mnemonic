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
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .preferredColorScheme(.dark)
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

//struct AppSwitcherView: View {
//    var body: some View {
//        ZStack {
//            AppColor.gradientPrimary
//                .ignoresSafeArea()
//            Image("update_illustration")
//        }
//    }
//}

