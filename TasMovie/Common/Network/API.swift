//
//  API.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation
import TasNetwork

class API: APIProtocol {
    public static let shared = API()
    
    public func requestAPI(url: String, with method: APIMethod, params: [String: String] = [:]) -> APIRequest {
        var paramsWithRequired: [String: String] = params
        paramsWithRequired.append(contentsOf: requiredParams())
        return NetworkManager.shared.requestQuery(url: url, with: method, headers: headers(), quries: paramsWithRequired)
    }
    
    public func requestAPIWithJsonBody(url: String, with method: APIMethod, params: [String: Any] = [:]) -> APIRequest {
        let query = query(from: requiredParams())
        return NetworkManager.shared.requestWithJsonBody(url: url + query, with: method, headers: headers(), body: params)
    }
    
    private func query(from dict: [String: String]) -> String {
        var query: String = ""
        if dict.isNotEmpty {
            query += "?"
            var isFirst = true
            for (index, element) in dict.enumerated() {
                if !isFirst {
                    query += "&"
                    isFirst = false
                }
                query += "\(element.key)=\(element.value)"
            }
        }
        return query
    }
    
    private func requiredParams() -> [String: String] {
        var params: [String: String] = [:]
        params["api_key"] = NetworkConst.API_KEY
        return params
    }
    
    private func headers() -> [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}
