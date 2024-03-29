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
    case failure(ErrorModel)
}

public protocol BaseJSONMappable: AnyObject {
    init(from json: [String: Any])
}

public class ErrorModel: BaseJSONMappable {
    public let success: Bool
    public let status_message: String
    public let status_code: Int
    
    public required init(from json: [String : Any]) {
        success = json.bool(itemKey: "success") ?? false
        status_message = json.string(itemKey: "status_message") ?? ""
        status_code = json.integer(itemKey: "status_code") ?? 0
    }
}

public protocol BaseJSONMapper: AnyObject {
    func toDictionary() -> [String: Any]
}

public protocol APIProtocol {
    func requestAPI(url: String, with method: APIMethod, params: [String: String]) -> APIRequest
    func requestAPIWithJsonBody(url: String, with method: APIMethod, params: [String: Any]) -> APIRequest
}

public class APIRequest {
    private let request: DataRequest
    
    public init(request: DataRequest) {
        self.request = request
    }
    
    public func send<ResultType: BaseJSONMappable>(completion: @escaping(APIResult<ResultType>) -> Void) {
        request.validate(statusCode: 200..<500)
            .responseString(completionHandler: { response in
                DispatchQueue.main.async {
                    if let jsonString = response.value, let jsonDict = jsonString.convertToDictionary() {
                        if response.error == nil {
                            if jsonDict["status_code"] == nil {
                                completion(.success(ResultType(from: jsonDict)))
                            } else {
                                completion(.failure(ErrorModel(from: jsonDict)))
                            }
                        } else if response.error?.isResponseValidationError == true {
                            completion(.failure(ErrorModel(from: jsonDict)))
                        }
                    } else if let error = response.error {
                        print(error.errorDescription ?? "")
                    }
                }
            })
    }
}

public class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}

    public func requestQuery(url: String, with method: APIMethod, headers: [String: String], quries: [String: Any] = [:]) -> APIRequest {
        return request(url: url, with: method, headers: headers, params: quries, isJsonBody: false)
    }
    
    public func requestWithJsonBody(url: String, with method: APIMethod, headers: [String: String], body: [String: Any] = [:]) -> APIRequest {
        return request(url: url, with: method, headers: headers, params: body, isJsonBody: true)
    }
    
    private func request(url: String, with method: APIMethod, headers: [String: String], params: [String: Any] = [:], isJsonBody: Bool) -> APIRequest {
        let encoding: ParameterEncoding = isJsonBody ? JSONEncoding.default : URLEncoding.default
        let dataRequest = AF.request(url, method: HTTPMethod(rawValue: method.rawValue), parameters: params, encoding: encoding, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil)
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
