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
            Rectangle()
                .foregroundColor(Color.mint)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            
            VStack {
                Image(systemName: "book.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("Guide!")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    GuideView()
}
