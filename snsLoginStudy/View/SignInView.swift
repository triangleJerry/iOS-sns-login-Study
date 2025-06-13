//
//  SignInView.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @EnvironmentObject private var auth: AuthViewModel

    var body: some View {
        
        VStack {
            
            Spacer()

            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    auth.handleAppleSignInSuccess(with: authorization)
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
    
    /// Apple 로그인 실패 처리
    private func handleAppleSignInFailure(with error: Error) {
        
        print("Could not authenticate: \(error.localizedDescription)")
    }
}

#Preview {
    SignInView()
}
