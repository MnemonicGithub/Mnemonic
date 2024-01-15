//
//  UIComponent.swift
//  mainApp
//
//  Created by Andy on 1/14/24.
//

import Foundation
import SwiftUI

struct SheetButton: View {
    @Binding var toggle: Bool
    let text: String
    
    var body: some View {
        Button(action: {
            toggle.toggle()
        }) {
            Text(text)
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: 200)
                .background(.cyan)
                .cornerRadius(10)
        }
    }
}

struct NavigationLinkButton: View {
    let text: String
    let viewValue: Int
    
    var body: some View {
        NavigationLink(value: viewValue) {
            Text(text)
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: 200)
                .background(Color.cyan)
                .cornerRadius(10)
        }
    }
}

struct NavigationLinkButtonTypeA: View {
    let text: String
    let viewValue: Int
    
    var body: some View {
        NavigationLink(value: viewValue) {
            Text(text)
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 3)
                )
                .cornerRadius(10)
        }
    }
}
