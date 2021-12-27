//
//  UserManager.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/27.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    private init() { }

    var requestToken: String? {
        get {
            UserDefaults.standard.string(forKey: "com.tas.movie.request_token")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "com.tas.movie.request_token")
        }
    }
    
    var username: String? {
        get {
            UserDefaults.standard.string(forKey: "com.tas.movie.username")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "com.tas.movie.username")
        }
    }
    
    
    var sessionId: String? {
        get {
            UserDefaults.standard.string(forKey: "com.tas.movie.session_id")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "com.tas.movie.session_id")
        }
    }
}
