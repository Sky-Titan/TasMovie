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
        return NetworkManager.shared.request(url: url, with: method, headers: headers(), params: paramsWithRequired)
    }
    
    public func requestAPIWithJsonBody(url: String, with method: APIMethod, params: [String: Any] = [:]) -> APIRequest {
        let addedParams = requiredParams()
        var url = url
        if addedParams.isNotEmpty {
            url += "?"
            var isFirst = true
            for (key, value) in addedParams.enumerated() {
                if !isFirst {
                    url += "&"
                    isFirst = false
                }
                url += "\(key)=\(value)"
            }
        }
        return NetworkManager.shared.requestWithJsonBody(url: url, with: method, headers: headers(), params: params)
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
