//
//  GuideView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct GuideView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                HStack(alignment:.top)
                {
                    Spacer()
                    
                    Image(AppImage.guidePage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .opacity(0.05)
                        .padding(.trailing, -50)
                }
            }
            
            VStack {
                Spacer()

                Text("GudieNoteContent")
                    .font(AppFont.fontBody3)
                    .foregroundStyle(AppColor.textHint)
                    .opacity(0.6)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(width: 360)
            }
            
            VStack(alignment: .leading, spacing: 30) {
                
                HStack (alignment: .firstTextBaseline, spacing: 20){
                    Image(AppImage.guidePageIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)

                    Text("GudieTitle")
                        .font(AppFont.fontH2)
                        .foregroundStyle(AppColor.textPrimary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                VStack(alignment: .leading, spacing: 25) {
                    Group {
                        GuideLine(image: "1.circle", stepTitle: "GuideStep1Title", stepContent: "GuideStep1Content")
                        GuideLine(image: "2.circle", stepTitle: "GuideStep2Title", stepContent: "GuideStep2Content")
                        GuideLine(image: "3.circle", stepTitle: "GuideStep3Title", stepContent: "GuideStep3Content", isCheckButton: true)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal)
        }
        .background(AppColor.backgroundColor)
        .presentationDragIndicator(.visible)
    }
}

struct GuideLine: View {
    var nfcOperationsHandler = NfcOperationsHandler()
    var image: String
    var stepTitle: LocalizedStringKey
    var stepContent: LocalizedStringKey
    var isCheckButton: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(AppColor.textHint)
                Image(AppImage.guidePageLine)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(stepTitle)
                    .font(AppFont.fontH3)
                    .foregroundStyle(AppColor.textHint)
                Text(stepContent)
                    .font(AppFont.fontBody2)
                    .foregroundStyle(AppColor.textPrimary)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                if isCheckButton {
                    Button(action: {
                        let _ = nfcOperationsHandler.startNFCTypeChecking()
                    }) {
                        SecondaryButton3Model(text: "CheckCardButton")
                    }
                }
            }
        }
    }
}

#Preview {
    GuideView()
}


