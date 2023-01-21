//
//  MyMovieViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase

class MyMovieViewController: TSViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.tabBarController = self.tabBarController
        tabBarHeight.constant = TabBarView.Const.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserManager.shared.requestAccountDetail(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                UserManager.shared.accountModel = response
                strongSelf.setupView()
            case .failure(let error):
                ViewManager.shared.showAlert(title: error.status_code.description, message: error.status_message, leftButtonTitle: "취소", rightButtonTitle: "확인")
            }
            
        })
    }
    
    private func setupView() {
        guard let model = UserManager.shared.accountModel, let avatarPath = model.avatar.tmdb.avatar_path else { return }
        avatarImageView.sd_setImage(with: URL(string: NetworkConst.ImageUrl.getWSizeImage(size: 200) + avatarPath))
    }
    
    
    @IBAction func logout(_ sender: Any) {
        UserManager.shared.requestLogout()
    }
}
