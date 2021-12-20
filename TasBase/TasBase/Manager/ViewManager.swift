//
//  ViewManager.swift
//  Practice
//
//  Created by 박준현 on 2021/12/07.
//

import Foundation
import UIKit

public class ViewManager {
    public static let shared = ViewManager()
    
    public var currentViewController: TSViewController? {
        return viewControllers.last
    }
    public var rootViewController: TSViewController? {
        return viewControllers.first
    }
    public var viewControllers: [TSViewController] = []
    
    private init() {}
    
    internal func appendViewController(viewController: TSViewController) {
        viewControllers.append(viewController)
    }
    
    internal func removeViewController() {
        viewControllers.removeLast()
    }
    
    public func presentViewController(_ viewControllerToPresent: TSViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        currentViewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    public func dismissViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        currentViewController?.dismiss(animated: animated, completion: completion)
    }
    
    public func pushViewController(viewController: TSViewController, animated: Bool) {
        currentViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func popViewController(animated: Bool) {
        currentViewController?.navigationController?.popViewController(animated: animated)
    }
}
