//
//  ColorDummyView.swift
//  Practice
//
//  Created by 박준현 on 2021/11/30.
//

import UIKit
import TasUtility

public class ColorDummyView: BaseXibView, FrontViewProtocol {
    public func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? ColorDummyViewModel else { return }
        backgroundColor = viewModel.color
    }
    
    public static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? ColorDummyViewModel else { return .zero }
        return CGSize(width: UIScreen.mainWidth, height: viewModel.height)
    }
    
    public override func nibName() -> String? {
        return "ColorDummyView"
    }
    
}
