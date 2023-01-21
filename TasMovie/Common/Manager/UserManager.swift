//
//  UserManager.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/27.
//

import Foundation
import TasBase

class UserManager: AccountDataProvider, AuthenticationDataProvider {
    static let shared = UserManager()
    
    private init() { }

    private(set) var requestToken: String? {
        get {
            UserDefaults.standard.string(forKey: "requestToken")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "requestToken")
            if newValue == nil {
                sessionId = nil
            }
        }
    }
    private(set) var tokenExpireTime: String? {
        get {
            UserDefaults.standard.string(forKey: "tokenExpireTime")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "tokenExpireTime")
        }
    }

    var tokenModel: NewTokenModel?
    
    var username: String? {
        return accountModel?.username
    }
    var userId: Int? {
        return accountModel?.id
    }
    var accountModel: AccountDetailModel?
    
    var sessionId: String? {
        get {
            UserDefaults.standard.string(forKey: "sessionId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sessionId")
            if sessionId != nil {
                requestAccountDetail()
            } else {
                ViewManager.shared.goToIntro()
            }
        }
    }
    
    private func requestAccountDetail() {
        requestAccountDetail(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.accountModel = response
            case .failure:
                ViewManager.shared.showNetworkError({
                    strongSelf.requestAccountDetail()
                })
            }
            
        })
    }
    
    func setRequestToken(_ tokenModel: NewTokenModel?) {
        self.requestToken = tokenModel?.request_token
        self.tokenExpireTime = tokenModel?.expires_at
    }
    
    func requestLogout() {
        guard let sessionId = sessionId else { return }
        requestLogout(session_id: sessionId, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let response):
                if response.success {
                    strongSelf.requestToken = nil
                }
            case .failure:
                ViewManager.shared.showNetworkError({
                    strongSelf.requestLogout()
                })
            }
        })
    }
}
