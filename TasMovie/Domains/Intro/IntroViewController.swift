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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRequestToken()
    }
    
    private func checkRequestToken() {
        guard UserManager.shared.requestToken != nil else {
            print("else")
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
            ViewManager.shared.goToMain()
        } else {
            let loginVC = SignInViewController()
            ViewManager.shared.currentViewController?.present(loginVC, animated: true, completion: nil)
        }
        
    }
}
