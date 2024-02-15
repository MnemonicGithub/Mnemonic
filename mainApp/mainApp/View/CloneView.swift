//
//  CloneView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct CloneView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var dataBox: DataBox
    @State var isSuccess: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                PrimaryActionBlockNoBorderModel(textTitle: "LandingC2CTitle", textContent: "LandingC2CContent", image: AppImage.landingC2C)
                CloneActionView(toggle: $isSuccess)
            }
            .background {
                Image(AppImage.actionWallpaper)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            if isSuccess {
                SuccessAlertModel(toggle: $isSuccess, content: "SuccessCloneContent") {
                    router.path = .init()
                }
                .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ToobarBackButtonModel()
            }
        }
    }
}

struct CloneActionView: View {
    @EnvironmentObject var dataBox: DataBox
    var nfcOperationsHandler = NfcOperationsHandler()
    @State var cloneData: String = ""
    @Binding var toggle: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                if let answer = nfcOperationsHandler.startNFCReading() {
                    dataBox.actionC2CStep1 = true
                    self.cloneData = answer
                } else {
                    dataBox.actionC2CStep1 = false
                }
            }) {
                if dataBox.actionC2CStep1 {
                    SecondaryStepBlock(textStep: "ActionSTEP1", textTitle: "C2CStep1Title", textContent: "C2CStep1Content")
                } else {
                    PrimaryStepBlock(textStep: "ActionSTEP1", textTitle: "C2CStep1Title", textContent: "C2CStep1Content")
                }
            }
            
            Button(action: {
                if (nfcOperationsHandler.startNFCWriting(rawString: cloneData)) {
                    withAnimation {
                        toggle.toggle()
                    }
                }
            }) {
                PrimaryStepBlock(textStep: "ActionSTEP2", textTitle: "C2CStep2Title", textContent: "C2CStep2Content")
                    .opacity(dataBox.actionC2CStep1 ? 1 : 0.4)
            }
            .disabled(!dataBox.actionC2CStep1)

            Spacer()
        }
    }
}

//struct cvStartReadView: View {
//    var body: some View {
//        SetBackground() {
//            VStack(alignment: .center, spacing: 30) {
//                
//                BackToRootButtonModel()
//
//            }
//            .padding(.top, 30)
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                ToobarBackButtonModel(title: "C2CStep1Title")
//            }
//        }
//    }
//}

//struct cvStartCloneView: View {
//    var body: some View {
//        SetBackground() {
//            VStack(alignment: .center, spacing: 30) {
//                
//                BackToRootButtonModel()
//
//            }
//            .padding(.top, 30)
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                ToobarBackButtonModel(title: "C2CStep2Title")
//            }
//        }
//    }
//}

struct CVPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            CloneView()
                .environmentObject(DataBox())
                .preferredColorScheme(.dark)
            
//            cvStartReadView()
//                .preferredColorScheme(.dark)
//            
//            cvStartCloneView()
//                .preferredColorScheme(.dark)
        }
    }
}
