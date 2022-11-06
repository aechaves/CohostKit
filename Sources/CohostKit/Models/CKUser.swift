//
//  CKUser.swift
//  
//
//  Created by Angelo Chaves on 2022-11-05.
//

import Foundation
import CryptoSwift

@available(macOS 12.0, *)
public struct CKUser {
    var id: Int64
    var email: String
    
    var sessionCookie: String?
    
    static func login(email: String, password: String) async throws -> CKUser {
        let salt: CKSalt = try await getSalt(for: email)
        let hash: String = try CryptoUtils.generateHash(password: password, salt: salt.decodedSalt!)
        
        let (data, response) = try await post(.login, body: ["email": email, "clientHash": hash])
        
        var cookie: String?
        if let headerCookie = response.value(forHTTPHeaderField: "set-cookie"), let firstCookie = headerCookie.split(separator: ";").first {
            cookie = String(firstCookie)
        }
        
        var user = try JSONDecoder().decode(CKUser.self, from: data)
        user.sessionCookie = cookie
        
        return user
    }
}

@available(macOS 12.0, *)
extension CKUser: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case email
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case sessionCookie
    }
}

