//
//  FakeResponse.swift
//  
//
//  Created by Angelo Chaves on 2022-11-06.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

class FakeResponse {
    @discardableResult init(url: String, statusCode: Int32 = 200, headers: [String: String]? = nil, jsonResponse: String? = "{}") throws {
        let obj = try JSONDecoder().decode(Dictionary<String,String>.self, from: Data(jsonResponse!.utf8))
        stub(condition: isHost(url)) { _ in
            return HTTPStubsResponse(jsonObject: obj, statusCode: statusCode, headers: nil)
        }
    }
    
    @discardableResult init(url: String, statusCode: Int32 = 200, headers: [String: String]? = nil, jsonResponse: [String: String]? = nil) throws {
        stub(condition: isHost(url)) { _ in
            return HTTPStubsResponse(jsonObject: jsonResponse!, statusCode: statusCode, headers: headers)
        }
    }
}
