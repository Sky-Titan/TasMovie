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
        checkIfNeededLogin()
    }
    
   
    private func checkIfNeededLogin() {
        if UserManager.shared.requestToken != nil {
            if let sessionId = UserManager.shared.sessionId, sessionId.isNotEmpty {
                ViewManager.shared.goToMain()
            } else {
                requestSession()
            }
        } else {
            let loginVC = SignInViewController()
            ViewManager.shared.currentViewController?.present(loginVC, animated: true, completion: nil)
        }
    }
    
    func requestSession() {
        guard let requestToken = UserManager.shared.requestToken else { return }
        requestNewSession(request_token: requestToken, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                UserManager.shared.sessionId = response.session_id
                ViewManager.shared.goToMain()
            case .failure(let error):
                ViewManager.shared.showAlert(title: error.status_code.description, message: error.status_message, leftButtonTitle: "취소", rightButtonTitle: "확인") {
                    strongSelf.requestSession()
                }
            }
            
        })
    }
}
