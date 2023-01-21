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
        requestTempToken()
    }
    
    func requestTempToken() {
        requestNewToken(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.requestLogin(response)
            case .failure(let error):
                ViewManager.shared.showAlert(title: "temp token 실패", message: error.status_message, leftButtonTitle: "취소", leftButtonHandler: nil, rightButtonTitle: "재시도", rightButtonHandler: {
                    strongSelf.requestTempToken()
                })
            }
        })
    }
    
    func requestLogin(_ tempToken: NewTokenModel) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        requestValidateWithLogin(username: username, password: password, request_token: tempToken.request_token, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                UserManager.shared.setRequestToken(response)
                strongSelf.requestSession()
            case .failure(let error):
                ViewManager.shared.showAlert(title: "로그인 실패", message: error.status_message, leftButtonTitle: "취소", leftButtonHandler: nil, rightButtonTitle: "재시도", rightButtonHandler: {
                    strongSelf.requestLogin(tempToken)
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
