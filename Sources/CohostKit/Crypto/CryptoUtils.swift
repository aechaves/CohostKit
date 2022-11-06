//
//  CryptoUtils.swift
//  
//
//  Created by Angelo Chaves on 2022-11-06.
//

import Foundation
import CryptoSwift

struct CryptoUtils {
    static func generateHash(password: [UInt8], salt: [UInt8], iterations: Int = 200000, keyLength: Int = 128, variant: HMAC.Variant = .sha2(.sha384)) throws -> [UInt8] {
        
        let hash = try PKCS5.PBKDF2(password: password, salt: salt, iterations: iterations, keyLength: keyLength, variant: variant).calculate()
        
        return hash
    }
    
    static func generateHash(password: [UInt8], salt: [UInt8], iterations: Int = 200000, keyLength: Int = 128, variant: HMAC.Variant = .sha2(.sha384)) throws -> String {
        
        return try generateHash(password: password, salt: salt, iterations: iterations, keyLength: keyLength, variant: variant).toBase64()
    }
    
    static func generateHash(password: String, salt: String) throws -> String {
        let decodedSalt = try salt.base64decoded(options: .omitPaddingCharacter)
        
        return try generateHash(password: password.bytes, salt: decodedSalt)
    }
    
    static func generateHash(password: String, salt: String) throws -> [UInt8] {
        let decodedSalt = try salt.base64decoded(options: .omitPaddingCharacter)
        
        return try generateHash(password: password.bytes, salt: decodedSalt)
    }
    
    static func generateHash(password: String, salt: [UInt8]) throws -> [UInt8] {
        return try generateHash(password: password.bytes, salt: salt)
    }
    
    static func generateHash(password: String, salt: [UInt8]) throws -> String {
        return try generateHash(password: password.bytes, salt: salt)
    }
}
