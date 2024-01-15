//
//  ContentView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()
}

struct ContentView: View {
    @StateObject var router: Router = Router()
    @State var isOpenLandingPageView = false
    @State var isOpenAboutUsView = false
    @State var isOpenGudieView = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Group {
                    SheetButton(toggle: $isOpenLandingPageView, text: "LandingPageView")
                    SheetButton(toggle: $isOpenAboutUsView, text: "AboutUsView")
                    SheetButton(toggle: $isOpenGudieView, text: "GuideView")
                }

                Group {
                    NavigationLinkButton(text: "BackupView", viewValue: PathInfo.backupViewValue)
                    NavigationLinkButton(text: "CloneView", viewValue: PathInfo.cloneViewValue)
                    NavigationLinkButton(text: "RestoreView", viewValue: PathInfo.restoreViewValue)
                }

            }
            .navigationDestination(for: Int.self) { viewValue in
                PathInfo.gotoLink(viewValue: viewValue)
            }
            .sheet(isPresented: $isOpenLandingPageView) {
                LandingPageView()
            }
            .sheet(isPresented: $isOpenAboutUsView) {
                AboutUsView()
            }
            .sheet(isPresented: $isOpenGudieView) {
                GuideView()
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .light)
}
