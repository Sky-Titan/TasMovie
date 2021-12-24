//
//  File.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation
import TasUtility
import Alamofire
import CoreData

public enum APIResult<ResponseT: BaseJSONMappable> {
    case success(ResponseT)
    case failure
}

public protocol BaseJSONMappable: AnyObject {
    init(from json: [String: Any])
}

public protocol APIProtocol {
    func requestAPI(url: String, with method: APIMethod, params: [String: String]) -> APIRequest
}

public class APIRequest {
    
    private let request: DataRequest
    
    public init(request: DataRequest) {
        self.request = request
    }
    
    public func send<ResultType: BaseJSONMappable>(completion: @escaping(APIResult<ResultType>) -> Void) {
        request.validate(statusCode: 200..<500)
            .responseString(completionHandler: { response in
                if let jsonString = response.value, let jsonDict = jsonString.convertToDictionary() {
                    if response.error == nil {
                        completion(.success(ResultType(from: jsonDict)))
                    } else {
                        completion(.failure)
                    }
                }
            })
    }
}

public class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}

    public func request(url: String, with method: APIMethod, headers: [String: String], params: [String: String] = [:]) -> APIRequest {
        let dataRequest = AF.request(url, method: HTTPMethod(rawValue: method.rawValue), parameters: params, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil)
        return APIRequest(request: dataRequest)
    }
}

public enum APIMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}
