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
            ZStack {
                Rectangle()
                    .foregroundColor(Color.brown)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                
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
}

struct BackupActionView: View {
    var body: some View {
        
        VStack {
            NavigationLinkButtonTypeA(text: "Set Mnemonic", viewValue: PathInfo.backupViewSetMnemonicValue)
            NavigationLinkButtonTypeA(text: "Set Password", viewValue: PathInfo.backupViewSetPasswordValue)
            NavigationLinkButtonTypeA(text: "Start Backup", viewValue: PathInfo.backupViewStartBackup)
            .navigationDestination(for: Int.self) { viewValue in
                PathInfo.gotoLink(viewValue: viewValue)
            }
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
}
