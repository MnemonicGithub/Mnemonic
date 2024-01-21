//
//  BackupView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import SwiftUI

struct BackupView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Image(systemName: "lock.shield")
                .imageScale(.large)
                .foregroundStyle(.white)
            Text("Backup!")
                .imageScale(.large)
                .foregroundStyle(.white)
            
            BackupActionView()
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

struct BackupActionView: View {
    var body: some View {
        
        VStack {
            NavigationBox(viewValue: PathInfo.backupViewSetMnemonicValue) {
                SecondaryButtonModel(text: "Set Mnemonic")
            }
            NavigationBox(viewValue: PathInfo.backupViewSetPasswordValue) {
                SecondaryButtonModel(text: "Set Password")
            }
            NavigationBox(viewValue: PathInfo.backupViewStartBackup) {
                SecondaryButtonModel(text: "Start Backup")
            }
        }
        .navigationDestination(for: Int.self) { viewValue in
            PathInfo.gotoLink(viewValue: viewValue)
        }
    }
}

struct bvSetMnemonicView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

struct bvSetPasswordView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        
        VStack {
            Button("Dismiss") {
                router.path = .init()
            }
        }
    }
}

struct bvStartBackView: View {
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
    BackupView()
        .preferredColorScheme(.dark)
}
