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
    
    
}
