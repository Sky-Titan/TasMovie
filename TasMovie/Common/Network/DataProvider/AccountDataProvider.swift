//
//  AccountDataProvider.swift
//  TasMovie
//
//  Created by 박준현 on 2022/01/01.
//

import UIKit
import TasNetwork

protocol AccountDataProvider: DataProvider {
    
}
extension AccountDataProvider {
    
    func requestAccountDetail(completion: @escaping(APIResult<AccountDetailModel>) -> Void) {
        var params: [String: String] = [:]
        if let session_id = UserManager.shared.sessionId {
            params["session_id"] = session_id
        }
        let api = api.requestAPI(url: NetworkConst.AccountUrl.getAccountDetail, with: .get, params: params)
        api.send(completion: completion)
    }
}
