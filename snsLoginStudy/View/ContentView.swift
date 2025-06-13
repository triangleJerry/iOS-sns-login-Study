//
//  ContentView.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var auth: AuthViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Sign Out") {
                auth.signOut()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
