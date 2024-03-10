//
//  LandingPageView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI


final class Router: ObservableObject {
    @Published var path = NavigationPath()
}

struct LandingPageView: View {
    @StateObject var router: Router = Router()
    @StateObject var dataBox = DataBox()
    @State var isOpenAboutUsView: Bool = false
    @State var isOpenGudieView: Bool = false
    @State var isInAppReview: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Image(AppImage.landingWallpaper)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("LandingHint")
                            .font(AppFont.fontBody1)
                            .foregroundStyle(AppColor.textPrimary)
                            .padding(.horizontal)
                        NavigationBox(viewValue: PathInfo.backupViewValue) {
                            PrimaryActionBlockModel(textTitle: "LandingW2CTitle", textContent: "LandingW2CContent", image: AppImage.landingW2C)
                        }
                        NavigationBox(viewValue: PathInfo.cloneViewValue) {
                            PrimaryActionBlockModel(textTitle: "LandingC2CTitle", textContent: "LandingC2CContent", image: AppImage.landingC2C)
                        }
                        NavigationBox(viewValue: PathInfo.restoreViewValue) {
                            PrimaryActionBlockModel(textTitle: "LandingC2WTitle", textContent: "LandingC2WContent", image: AppImage.landingC2W)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("LandingTitle")
                            .font(AppFont.fontH)
                            .foregroundStyle(AppColor.textPrimary)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(alignment: .center, spacing: 20) {
                            ButtonBox(toggle: $isOpenGudieView) {
                                SecondaryIconButtonModel(image: AppImage.guide)
                            }
                            ButtonBox(toggle: $isOpenAboutUsView) {
                                SecondaryIconButtonModel(image: AppImage.aboutUs)
                            }
                        }
                    }
                }                
                .onAppear {
                    dataBox.clearData()
                }
                .sheet(isPresented: $isOpenGudieView) {
                    GuideView()
                }
                .sheet(isPresented: $isOpenAboutUsView) {
                    AboutUsView()
                }
                .navigationDestination(for: Int.self) { viewValue in
                    PathInfo.gotoLink(viewValue: viewValue)
                }
                
                if isInAppReview {
                    InAppReviewAlertModel(toggle: $isInAppReview)
                        .zIndex(1)
                }
            }
            .background {
                Image(AppImage.actionWallpaper)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .onAppear {
                let inAppReviewAlert = InAppReviewAlert()
                if inAppReviewAlert.getIsAlert() && !inAppReviewAlert.getIsRate() {
                    isInAppReview.toggle()
                }
            }
        }
        .environmentObject(router)
        .environmentObject(dataBox)
    }
}

#Preview {
    LandingPageView()
        .preferredColorScheme(.dark)
}
