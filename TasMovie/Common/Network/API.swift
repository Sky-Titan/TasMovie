//
//  API.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation
import TasNetwork

class API {
    public static let shared = API()
    
    public func requestAPI(url: String, with method: APIMethod, params: [String: String] = [:]) -> APIRequest {
        var paramsWithRequired: [String: String] = params
        paramsWithRequired.append(contentsOf: requiredParams())
        return NetworkManager.shared.requestAPI(url: url, with: method, headers: getHeaders(), params: paramsWithRequired)
    }
    
    private func requiredParams() -> [String: String] {
        var params: [String: String] = [:]
        params["api_key"] = NetworkConst.API_KEY
        return params
    }
    
    private func getHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}