//
//  RootView.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var auth: AuthViewModel
    
    var body: some View {
        
        Group {
            if auth.isLoggedIn {
                ContentView()
            } else {
                SignInView()
            }
        }
    }
}

#Preview {
    RootView()
}
