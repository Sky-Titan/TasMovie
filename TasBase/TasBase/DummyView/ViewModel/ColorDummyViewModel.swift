//
//  ColorDummyViewModel.swift
//  Practice
//
//  Created by 박준현 on 2021/12/10.
//

import UIKit
import TasUtility

public class ColorDummyViewModel: FrontViewModelProtocol {
    public var frontViewProperty: FrontViewProperty
    public var color: UIColor
    public var height: CGFloat
    public init(color: UIColor = .clear, height: CGFloat = 0) {
        self.color = color
        self.height = height
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: ColorDummyView.className())
        frontViewProperty.cellSize = ColorDummyView.size(self)
    }
}
