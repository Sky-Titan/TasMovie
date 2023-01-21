//
//  ViewManager.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/28.
//

import UIKit
import TasBase

extension ViewManager {
    
    public func goToMain() {
        let window = currentViewController?.view.window
        
        window?.rootViewController?.dismiss(animated: false, completion: {
            let rootVC = UITabBarController()
            let viewControllerList: [UIViewController] = [SearchResultViewController(), SecondViewController(), MyMovieViewController()]
            rootVC.setViewControllers(viewControllerList.map{
                let navVC = UINavigationController(rootViewController: $0)
                navVC.navigationBar.isHidden = true
                return navVC
            }, animated: false)
            rootVC.tabBar.isHidden = true
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
        })
    }
    
    public func goToIntro() {
        let window = currentViewController?.view.window
        window?.rootViewController = IntroViewController()
        window?.makeKeyAndVisible()
    }
}
