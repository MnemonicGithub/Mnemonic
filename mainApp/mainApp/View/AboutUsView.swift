//
//  AboutUsView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct AboutUsView: View {
    let websiteURL = URL(string: AppLink.contactUs)!
    @State var isCopyAddress: Bool = false

    var body: some View {
        ZStack {
            AppColor.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack (spacing: 0) {
                    Group {
                        Image(AppImage.aboutLine1)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                            .padding(.bottom)
                        
                        HStack(alignment: .top) {
                            Image(AppImage.aboutIcon1)
                                .opacity(0.1)
                                .padding(.horizontal)
                            
                            VStack (alignment: .leading, spacing: 10){
                                Text("AboutTitle1")
                                    .foregroundColor(AppColor.textPrimary)
                                    .font(AppFont.fontH2)
                                Text("AboutContent1")
                                    .foregroundColor(AppColor.textPrimary)
                                    .font(AppFont.fontBody1)
                            }
                            .padding(.leading, -60)
                            .padding(.trailing)
                            .padding(.vertical)
                            
                            Spacer()
                        }

                        Image(AppImage.aboutLine2)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                    }

                    Group {
                        HStack {
                            Spacer()
                            
                            Image(AppImage.aboutIcon2)
                                .opacity(0.4)
                                .padding(.horizontal)
                        }
                        .overlay(alignment: .bottom) {
                            Image(AppImage.aboutLine3)
                                .resizable()
                                .scaledToFit()
                                .ignoresSafeArea()
                        }
                        .overlay(alignment: .top) {
                            HStack {
                                VStack (alignment: .leading, spacing: 10){
                                    Text("AboutTitle2")
                                        .foregroundColor(AppColor.textPrimary)
                                        .font(AppFont.fontH2)
                                    Text("AboutContent2")
                                        .foregroundColor(AppColor.textPrimary)
                                        .font(AppFont.fontBody1)
                                        .frame(width: 280)
                                }
                                .padding(.top)
                            }
                    }
                    }
                    
                    Group {
                        HStack(alignment: .lastTextBaseline) {
                            Image(AppImage.aboutIcon3)
                                .opacity(0.8)
                                .padding(.horizontal)
                            
                            VStack (alignment: .leading, spacing: 10){
                                Text("AboutTitle3")
                                    .foregroundColor(AppColor.textPrimary)
                                    .font(AppFont.fontH2)
                                Text("AboutContent3")
                                    .foregroundColor(AppColor.textPrimary)
                                    .font(AppFont.fontBody1)
                            }
                            .padding(.trailing)
                            
                        }
                        .padding(.vertical)
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("AboutContent4")
                            .foregroundColor(AppColor.textPrimary)
                            .font(AppFont.fontBody1)
                            .frame(width: 290)
                            .overlay(alignment: .topTrailing) {
                                Button(action: {
                                    UIApplication.shared.open(websiteURL)
                                }) {
                                    Image(systemName: "envelope.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(AppColor.iconSecondary)
                                        .padding(.trailing, 6)
                                }
                            }
                    }
                    .padding()

                    VStack (spacing: 10){
                        Image(AppImage.aboutQRcode)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .opacity(0.8)

                        
                        Button(action: {
                            UIPasteboard.general.string = AppLink.address
                            isCopyAddress.toggle()
                        }) {
                            Text(AppLink.address)
                                .foregroundColor(AppColor.textPoint)
                                .font(AppFont.fontCaption)
                                .frame(width: 200)
                                .underline()
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                }
                .padding(.top, 50)
            }
            .scrollIndicators(.hidden)
            .presentationDragIndicator(.visible)
            .alert(isPresented: $isCopyAddress) {
                Alert(title: Text("CopyTitle"), message: Text("AboutCopyAddress"), dismissButton: .default(Text("SuccessButton")))
            }
        }
    }
}

#Preview {
    AboutUsView()
}
