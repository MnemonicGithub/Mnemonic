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
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    @State private var hearts: [UUID] = []
    @State private var timer: Timer?
    
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
                                    .foregroundStyle(AppColor.gradientPrimary)
                                    .font(AppFont.fontH2)
                                Text("AboutContent1")
                                    .foregroundStyle(AppColor.textPrimary)
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
                                .opacity(0.3)
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
                                        .foregroundStyle(AppColor.gradientPrimary)
                                        .font(AppFont.fontH2)
                                    Text("AboutContent2")
                                        .foregroundStyle(AppColor.textPrimary)
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
                                .padding(.horizontal)
                            
                            VStack (alignment: .leading, spacing: 10){
                                Text("AboutTitle3")
                                    .foregroundStyle(AppColor.gradientPrimary)
                                    .font(AppFont.fontH2)
                                Text("AboutContent3")
                                    .foregroundStyle(AppColor.textPrimary)
                                    .font(AppFont.fontBody1)
                            }
                            .padding(.trailing)
                            
                        }
                        .padding(.vertical)
                    }

                    Group {
                        HStack(alignment: .top, spacing: 0) {
                            Text("AboutContent4")
                                .foregroundStyle(AppColor.textPrimary)
                                .font(AppFont.fontBody1)
                                .frame(width: 290)
                                .overlay(alignment: .topTrailing) {
                                    Button(action: {
                                        UIApplication.shared.open(websiteURL)
                                    }) {
                                        Image(systemName: AppImage.contactUs)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35)
                                            .foregroundStyle(AppColor.iconSecondary)
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
                            
                            Button {
                                UIPasteboard.general.string = AppLink.address
                                impactFeedbackGenerator.impactOccurred()
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.2, blendDuration: 10)) {
                                    hearts.append(UUID())
                                }
                                
                                self.timer?.invalidate()
                                self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                    hearts.removeAll()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: AppImage.copyToClipboard)
                                    Text(AppLink.address)
                                        .underline()
                                        .multilineTextAlignment(.center)
                                }
                                .foregroundStyle(AppColor.gradientPrimary)
                                .font(AppFont.fontCaption)
                                .frame(width: 200)
                            }
                        }
                        .padding()
                    }
                }
                .padding(.top, 50)
            }
            .background {
                ForEach(hearts, id: \.self) { heartID in
                    Image(systemName:AppImage.buyMeCoffee)
                        .resizable()
                        .scaledToFit()
                        .frame(width: CGFloat.random(in: 10...30))
                        .foregroundStyle(Color.random)
                        .opacity(0.8)
                        .scaleEffect(1)
                        .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                        .id(heartID)
                }
            }
            .scrollIndicators(.hidden)
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            impactFeedbackGenerator.prepare()
        }
    }
}

#Preview {
    AboutUsView()
}
