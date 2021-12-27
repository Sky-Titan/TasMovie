//
//  IntroViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/27.
//

import UIKit
import TasBase

class IntroViewController: TSViewController, AuthenticationDataProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRequestToken()
    }
    
    private func checkRequestToken() {
        guard UserManager.shared.requestToken != nil else {
            requestNewToken()
            return
        }
        
        checkIfNeededLogin()
    }
    
    private func requestNewToken() {
        requestNewToken(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                if response.success {
                    UserManager.shared.requestToken = response.request_token
                    strongSelf.checkRequestToken()
                }
            case .failure(let error):
                strongSelf.showAlert(title: "네트워크 오류", message: error.status_message, leftButtonTitle: "취소", leftButtonHandler: nil, rightButtonTitle: "재시도", rightButtonHandler: {
                    strongSelf.requestNewToken()
                })
            }
            
        })
    }
    
    private func checkIfNeededLogin() {
        if UserManager.shared.sessionId != nil {
            // TODO: go to main tab
        } else {
            //TODO: go to login page
            /*
             enter username, password and request new token with validate,
             and create session with new token
             */
        }
        
    }
}
