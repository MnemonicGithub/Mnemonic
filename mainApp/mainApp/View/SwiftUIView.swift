//
//  SwiftUIView.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import SwiftUI

struct SwiftUIView: View {
    
    @StateObject var router: Router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            RowListsView()
            .navigationDestination(for: Int.self) { i in
                RowListsView()
            }
        }
        .environmentObject(router)
    }
}

struct RowListsView : View{
    
    @EnvironmentObject var router: Router
    
    var body: some View{
        
        Form{
            List(1..<5) { i in
                NavigationLink(value: i) {
                    Text("\(i)")
                }
            }
            Section{
                
                if router.path.count > 0
                {
                    Button("Screen count \(router.path.count)"){
                        print("")
                    }
                    
                    Button("Pop to root", role: .destructive){
                        router.path = .init()
                    }
                    
                    Button("Jump back two screens", role: .none){
                        
                        if router.path.count >= 2{
                            router.path.removeLast(2)
                        }
                        else if router.path.count >= 1{
                            router.path.removeLast(1)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
