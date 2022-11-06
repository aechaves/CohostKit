//
//  File.swift
//  
//
//  Created by Angelo Chaves on 2022-11-05.
//

import Foundation


public struct CKSalt: Codable {
    var salt: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.salt = try container.decode(String.self, forKey: .salt)
        
        // Love computers: https://cohost.org/iliana/post/180187-eggbug-rs-v0-1-3-d
        self.salt = self.salt.replacingOccurrences(of: "-", with: "A").replacingOccurrences(of: "_", with: "A").appending("==")
    }
}
