//
//  snsLoginStudyApp.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI

@main
struct snsLoginStudyApp: App {
    
    @StateObject private var auth = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
        }
    }
}
