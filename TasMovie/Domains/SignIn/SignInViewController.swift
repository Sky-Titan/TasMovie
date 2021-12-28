//
//  SignInViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/28.
//

import UIKit
import TasBase

class SignInViewController: TSViewController, AuthenticationDataProvider {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        requestLogin()
    }
    
    func requestLogin() {
        guard let username = usernameTextField.text, let password = passwordTextField.text, let requestToken = UserManager.shared.requestToken else { return }
        requestValidateWithLogin(username: username, password: password, request_token: requestToken, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                if response.success {
                    UserManager.shared.requestToken = response.request_token
                    strongSelf.requestSession()
                }
            case .failure(let error):
                ViewManager.shared.showAlert(title: "로그인 실패", message: error.status_message, leftButtonTitle: "취소", leftButtonHandler: nil, rightButtonTitle: "재시도", rightButtonHandler: {
                    strongSelf.requestLogin()
                })
            }
            
        })
    }
    
    func requestSession() {
        guard let requestToken = UserManager.shared.requestToken else { return }
        requestNewSession(request_token: requestToken, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                if response.success {
                    UserManager.shared.sessionId = response.session_id
                    ViewManager.shared.goToMain()
                }
            case .failure(let error):
                ViewManager.shared.showAlert(title: "세션 실패", message: error.status_message, leftButtonTitle: "취소", leftButtonHandler: nil, rightButtonTitle: "재시도", rightButtonHandler: {
                    strongSelf.requestSession()
                })
            }
            
        })
    }
}
