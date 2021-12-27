//
//  TSViewController.swift
//  TasBase
//
//  Created by 박준현 on 2021/11/29.
//

import UIKit

open class TSViewController: UIViewController {
    private var indicator: UIActivityIndicatorView?
    
    deinit {
        print("\(self.description) deallocation succeed =====")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewManager.shared.appendViewController(viewController: self)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ViewManager.shared.removeViewController(viewController: self)
    }
    
    open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    public func showIndicator() {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .gray
        indicator.frame = view.frame
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
        indicator.bindingToSuperview()
        
        self.indicator = indicator
        indicator.startAnimating()
    }
    
    public func removeIndicator() {
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
    }
    
    public func showNetworkError(_ handler: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: "네트워크 오류", message: "다시 시도해주십시오.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "다시 시도", style: .default, handler: { _ in
            handler()
        })
        
        alert.addAction(defaultAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    public func showAlert(title: String, message: String, leftButtonTitle: String, leftButtonHandler: (() -> Void)? = nil, rightButtonTitle: String, rightButtonHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: leftButtonTitle, style: .cancel, handler: { _ in
            leftButtonHandler?()
        })
        let defaultAction = UIAlertAction(title: rightButtonTitle, style: .default, handler: { _ in
            rightButtonHandler?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        self.present(alert, animated: false, completion: nil)
    }
}
