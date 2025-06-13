//
//  SignInView.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {

    var body: some View {
        
        VStack {
            
            Spacer()

            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    handleAppleSignInSuccess(with: authorization)
                case .failure(let error):
                    handleAppleSignInFailure(with: error)
                }
            }
            .frame(height: 56)
            .padding()
        }
        .padding()
    }
    
    // MARK: - func
    
    /// Apple 로그인 성공 처리
    private func handleAppleSignInSuccess(with authorization: ASAuthorization) {
        
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = userCredential.user
            KeychainHelper.shared.save(Data(userId.utf8), service: "com.snsLoginStudy", account: "userId")
            
            if let fullName = userCredential.fullName?.givenName {
                KeychainHelper.shared.save(Data(fullName.utf8), service: "com.snsLoginStudy", account: "fullName")
            }
            
            if let email = userCredential.email {
                KeychainHelper.shared.save(Data(email.utf8), service: "com.snsLoginStudy", account: "email")
            }
        }
    }
    
    /// Apple 로그인 실패 처리
    private func handleAppleSignInFailure(with error: Error) {
        
        print("Could not authenticate: \(error.localizedDescription)")
    }
}

#Preview {
    SignInView()
}
