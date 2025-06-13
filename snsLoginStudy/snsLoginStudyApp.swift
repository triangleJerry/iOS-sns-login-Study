//
//  snsLoginStudyApp.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI

@main
struct snsLoginStudyApp: App {
    
    // 로그인 상태 추적
    @State private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    ContentView()
                } else {
                    SignInView()
                }
            }
            // 뷰 표시 시 키체인 확인
            .onAppear {
                // Check if userId exists in Keychain to set login state
                isLoggedIn = (KeychainHelper.shared.read(service: "com.snsLoginStudy", account: "userId") != nil)
            }
        }
    }
}
