//
//  File.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation
import TasUtility
import Alamofire

public enum APIResult<ResponseT: BaseJSONMappable> {
    case success(ResponseT)
    case failure
}

public protocol BaseJSONMappable: AnyObject {
    init(from json: [String: Any])
}

public class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}

    public func requestAPI<ResultType: BaseJSONMappable>(url: String, with method: HTTPMethod, params: [String: String], resultType: ResultType.Type, completionHandler: @escaping (APIResult<ResultType>) -> Void) {
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: getHeaders(), interceptor: nil, requestModifier: nil)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: String.self) { response in
                if let jsonString = response.value, let jsonDict = jsonString.convertToDictionary() {
                    if response.error == nil {
                        completionHandler(.success(ResultType(from: jsonDict)))
                    } else {
                        completionHandler(.failure)
                    }
                }
            }
    }
    
    private func getHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}
