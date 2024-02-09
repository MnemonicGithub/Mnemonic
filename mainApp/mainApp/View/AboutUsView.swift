//
//  AboutUsView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            AppColor.backgroundColor
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    
//                    HStack(alignment: .center) {
//                        Spacer()
//
//                        Button(action: {
//                            dismiss()
//                        }) {
//                            Image(systemName: "chevron.down.circle.fill")
//                                .font(.largeTitle)
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .padding(.top)
//                    .padding(.trailing)
                    
                    Text("Welcome and join our story!")
                        .font(AppFont.fontH2)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")
                    Image("update_illustration")

                }
                .padding(.top, 20)
                .padding()
            }
            .scrollIndicators(.hidden)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.automatic)
        }
    }
}

#Preview {
    AboutUsView()
}
