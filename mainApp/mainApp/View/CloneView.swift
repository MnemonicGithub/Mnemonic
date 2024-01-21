//
//  CloneView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct CloneView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Image(systemName: "doc.on.doc.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
            Text("Clone!")
                .imageScale(.large)
                .foregroundStyle(.white)
            
            CloneActionView()
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

struct CloneActionView: View {
    var body: some View {
        
        VStack {
            NavigationBox(viewValue: PathInfo.backupViewSetMnemonicValue) {
                SecondaryButtonModel(text: "Start Read")
            }
            NavigationBox(viewValue: PathInfo.backupViewSetPasswordValue) {
                SecondaryButtonModel(text: "Start Clone")
            }
        }
        .navigationDestination(for: Int.self) { viewValue in
            PathInfo.gotoLink(viewValue: viewValue)
        }
    }
}

struct cvStartReadView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

struct cvStartCloneView: View {
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
    CloneView()
        .preferredColorScheme(.dark)
}
