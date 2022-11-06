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
    case user = "/login"
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
public func getSalt(for email: String) async throws -> CKSalt {
    return try await get(.salt, parameters: ["email": email])
}

@available(macOS 12.0, *)
public func getSalt(for email: String) async throws -> String {
    let salt: CKSalt = try await get(.salt, parameters: ["email": email])
    return salt.salt
}

// MARK: - POST

@available(macOS 12.0, *)
public func post(_ endpoint: CKEndpoint, body: [String: String]? = nil) async throws -> (Data, HTTPURLResponse) {
    guard let url = URL(string: API_BASE + endpoint.rawValue) else { fatalError("Incorrect URL.") }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let body {
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
    }
    
    let (data, r) = try await URLSession.shared.data(for: request)
    if let response = r as? HTTPURLResponse {
        guard response.statusCode == 200 else {
            let errorMessage = """
Error: \(response.statusCode) | \(String(data: data, encoding: .utf8) ?? "{}").
URL: \(url.absoluteString).
Body: \(String(describing: body))
"""
            fatalError(errorMessage)
            
        }
        
        return (data, response)
    } else {
        fatalError("Not a HTTP Response.")
    }
}

@available(macOS 12.0, *)
public func post<Model: Codable>(_ endpoint: CKEndpoint, body: [String: String]? = nil) async throws -> Model {
    let (data, _) = try await post(endpoint, body: body)
    return try JSONDecoder().decode(Model.self, from: data)
}
