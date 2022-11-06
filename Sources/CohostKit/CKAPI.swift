//
//  CKAPI.swift
//  
//
//  Created by Angelo Chaves on 2022-11-05.
//

import Foundation

// MARK: - Endpoints and structures

let API_BASE = "https://cohost.org/api/v1"

public enum CKEndpoint: String {
    case salt = "/login/salt"
}

public struct APIResponse: Codable {
    
}

// MARK: - GET

@available(macOS 12.0, *)
public func get(_ endpoint: CKEndpoint, parameters: [String: String]? = nil) async throws -> (Data, HTTPURLResponse) {
    guard let url = URL(string: API_BASE + endpoint.rawValue) else { fatalError("Incorrect URL.") }
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    if let parameters {
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    let request = URLRequest(url: components?.url ?? url)
    
    let (data, r) = try await URLSession.shared.data(for: request)
    if let response = r as? HTTPURLResponse {
        guard response.statusCode == 200 else {
            let errorMessage = """
Error: \(response.statusCode).
URL: \(url.absoluteString).
Parameters: \(String(describing: parameters))
"""
            fatalError(errorMessage)
            
        }
        
        return (data, response)
    } else {
        fatalError("Not a HTTP Response.")
    }
}

@available(macOS 12.0, *)
public func get<Model: Codable>(_ endpoint: CKEndpoint, parameters: [String: String]? = nil) async throws -> Model {
    let (data, _) = try await get(endpoint, parameters: parameters)
    return try JSONDecoder().decode(Model.self, from: data)
}

@available(macOS 12.0, *)
public func getSalt(for email: String) async throws -> String {
    let salt: CKSalt = try await get(.salt, parameters: ["email": email])
    return salt.salt
}
