//
//  RestoreView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct RestoreView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Image(systemName: "text.word.spacing")
                .imageScale(.large)
                .foregroundStyle(.white)
            Text("Restore!")
                .imageScale(.large)
                .foregroundStyle(.white)
            
            RestoreActionView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct RestoreActionView: View {
    var body: some View {
        
        VStack {
            NavigationBox(viewValue: PathInfo.restoreViewStartReadValue) {
                SecondaryButtonModel(text: "Start Read")
            }
            NavigationBox(viewValue: PathInfo.restoreViewEnterPasswordValue) {
                SecondaryButtonModel(text: "Enter Password")
            }
            NavigationBox(viewValue: PathInfo.restoreViewShowMnemonicValue) {
                SecondaryButtonModel(text: "Show Mnemonic")
            }
            
        }
        .navigationDestination(for: Int.self) { viewValue in
            PathInfo.gotoLink(viewValue: viewValue)
        }
    }
}

struct rvStartReadView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

struct rvEnterPassworView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

struct rvShowMnemonicView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

#Preview {
    RestoreView()
        .preferredColorScheme(.dark)
}
