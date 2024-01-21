//
//  InAppStoreReviewView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI
import StoreKit


struct InAppStoreReviewView: View {
    @Environment(\.requestReview) var requestReview
    @State var showLike: Bool = false
    let buttonColor = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(red: 0.87, green: 1, blue: 0.7), location: 0.01),
            .init(color: Color(red: 0.84, green: 0.98, blue: 0.47), location: 0.45),
            .init(color: Color(red: 0.82, green: 0.98, blue: 0.49), location: 0.50),
            .init(color: Color(red: 0.66, green: 0.96, blue: 0.71), location: 1.00),
        ]),
        startPoint: UnitPoint(x: 0.42, y: -0.51),
        endPoint: UnitPoint(x: 0.58, y: 1.51)
    )
    
    var body: some View {
        VStack {
            Button(action: {
                showLike.toggle()
            }) {
                Text("Review the app")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: 200)
                    .background(buttonColor)
                    .cornerRadius(10)
            }
        }
        .padding()
        .alert(isPresented: $showLike) {
            Alert(
                title: Text("Enjoying our App"),
                message: Text("Your 5-star review is the energy for our, thank you very much!"),
                primaryButton: .default(
                    Text("Yes"),
                    action: {
                        requestReview()
                    }
                ),
                secondaryButton: .cancel(
                    Text("Not now")
                )
            )
        }
    }
    
    func presentReview() {
        Task {
            // Delay for two seconds to avoid interrupting the person using the app.
            try await Task.sleep(for: .seconds(2))
            await requestReview()
        }
    }
}

#Preview {
    InAppStoreReviewView()
}
