//
//  BaseListCellViewProtocol.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

protocol BaseListCellViewProtocol: AnyObject {
    var frontView: UIView? { get set }
    func setViewModel(_ viewModel: FrontViewModelProtocol, to superview: UIView)
    static var identifierStringForReuse: String { get }
}

extension BaseListCellViewProtocol {
    
    static var identifierStringForReuse: String {
        return String(describing: Self.self)
    }
    
    func setViewModel(_ viewModel: FrontViewModelProtocol, to superview: UIView) {
        if let frontView = frontView as? FrontViewProtocol {
            frontView.setViewModel(viewModel)
        } else {
            let viewClass = viewModel.frontViewProperty.className
            let type = NSClassFromString(viewClass) as! UIView.Type
            let view = type.init(frame: superview.frame)
            superview.addSubview(view)
            view.bindingToSuperview()
            self.frontView = view
            
            if let view = view as? FrontViewProtocol {
                view.setViewModel(viewModel)
            }
        }
    }
}
