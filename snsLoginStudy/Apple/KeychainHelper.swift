//
//  KeychainHelper.swift
//  snsLoginStudy
//
//  Created by 장은석 on 6/13/25.
//

import AuthenticationServices

// MARK: - Keychain Helper (키체인 저장 유틸리티)
/// 키체인에 데이터 저장 및 읽기 기능 제공
struct KeychainHelper {
    
    static let shared = KeychainHelper()

    /// 키체인에 데이터 저장
    /// - Parameters:
    ///   - data: 저장할 데이터
    ///   - service: 서비스 식별자
    ///   - account: 계정 식별자
    func save(_ data: Data, service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    /// 키체인에서 데이터 읽기
    /// - Parameters:
    ///   - service: 서비스 식별자
    ///   - account: 계정 식별자
    /// - Returns: 저장된 데이터 또는 nil
    func read(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { return nil }
        return item as? Data
    }

    /// 키체인에서 데이터 삭제
    /// - Parameters:
    ///   - service: 서비스 식별자
    ///   - account: 계정 식별자
    func delete(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
