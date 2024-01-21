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
    @State var isOpenDententView: Bool = false
    @State var isOpenAboutUsView: Bool = false
    @State var isOpenGudieView: Bool = false
    


    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Group {
                    HStack {
                        ButtonBox(toggle: $isOpenGudieView) {
                            PrimaryIconButtonModel(image: "bell")
                        }
                        ButtonBox(toggle: $isOpenAboutUsView) {
                            PrimaryIconButtonModel(image: "info.circle")
                        }
                    }
                    ButtonBox(toggle: $isOpenDententView) {
                        SecondaryButtonModel(text: "Detent")
                    }
                }

                Group {
                    NavigationBox(viewValue: PathInfo.landingPageViewValue) {
                        PrimaryButtonModel(text: "LandingPageView")
                    }
                    NavigationBox(viewValue: PathInfo.backupViewValue) {
                        PrimaryButtonModel(text: "BackupView")
                    }
                    NavigationBox(viewValue: PathInfo.cloneViewValue) {
                        PrimaryButtonModel(text: "CloneView")
                    }
                    NavigationBox(viewValue: PathInfo.restoreViewValue) {
                        PrimaryButtonModel(text: "RestoreView")
                    }
                }
            }
            .navigationDestination(for: Int.self) { viewValue in
                PathInfo.gotoLink(viewValue: viewValue)
            }
            .sheet(isPresented: $isOpenDententView) {
                DententView()
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
        .preferredColorScheme(.dark)
 }
