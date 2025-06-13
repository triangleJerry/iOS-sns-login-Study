//
//  AuthViewModel.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI
import AuthenticationServices

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false

    init() {
        isLoggedIn = (KeychainHelper.shared.read(service: "greeneyes.snsLoginStudy", account: "userId") != nil)
    }

    /// Apple 로그인 성공 처리
    func handleAppleSignInSuccess(with authorization: ASAuthorization) {
        
        guard let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        let userId = userCredential.user
        KeychainHelper.shared.save(Data(userId.utf8), service: "greeneyes.snsLoginStudy", account: "userId")
        
        if let fullName = userCredential.fullName?.givenName {
            KeychainHelper.shared.save(Data(fullName.utf8), service: "greeneyes.snsLoginStudy", account: "fullName")
        }
        
        if let email = userCredential.email {
            KeychainHelper.shared.save(Data(email.utf8), service: "greeneyes.snsLoginStudy", account: "email")
        }
        
        isLoggedIn = true
    }
    
    func signOut() {
        
        KeychainHelper.shared.delete(service: "greeneyes.snsLoginStudy", account: "userId")
        KeychainHelper.shared.delete(service: "greeneyes.snsLoginStudy", account: "fullName")
        KeychainHelper.shared.delete(service: "greeneyes.snsLoginStudy", account: "email")
        isLoggedIn = false
    }
}
