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
            Rectangle()
                .foregroundColor(Color.orange)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            
            VStack {
                Image(systemName: "person.3.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("About Us!")
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
    AboutUsView()
}
