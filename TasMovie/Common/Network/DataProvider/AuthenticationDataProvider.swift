//
//  AuthenticationDataProvider.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import Foundation
import TasNetwork

protocol AuthenticationDataProvider: DataProvider {
    
}
extension AuthenticationDataProvider {
    
    func requestNewToken(completion: @escaping(APIResult<NewTokenModel>) -> Void) {
        let api = api.requestAPI(url: NetworkConst.AuthenticationUrl.getNewToken, with: .get)
        api.send(completion: completion)
    }
    
    func requestNewSession(request_token: String, completion: @escaping(APIResult<NewSessionModel>) -> Void) {
        let params: [String: Any] = ["request_token": request_token]
        let api = api.requestAPIWithJsonBody(url: NetworkConst.AuthenticationUrl.createNewSession, with: .post, params: params)
        api.send(completion: completion)
    }
    
    func requestValidateWithLogin(username: String, password: String, request_token: String, completion: @escaping(APIResult<NewTokenModel>) -> Void) {
        let params: [String: Any] = ["username": username, "password": password, "request_token": request_token]
        let api = api.requestAPIWithJsonBody(url: NetworkConst.AuthenticationUrl.requestValidateWithLogin, with: .post, params: params)
        api.send(completion: completion)
    }
    
    func requestLogout(session_id: String, completion: @escaping(APIResult<SuccessModel>) -> Void) {
        let params: [String: Any] = ["session_id": session_id]
        let api = api.requestAPIWithJsonBody(url: NetworkConst.AuthenticationUrl.logout, with: .delete, params: params)
        api.send(completion: completion)
    }
}
