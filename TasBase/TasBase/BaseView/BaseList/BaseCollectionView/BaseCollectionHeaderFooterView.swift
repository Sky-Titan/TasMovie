//
//  BaseCollectionHeaderFooterView.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

class BaseCollectionHeaderFooterView: UICollectionReusableView, BaseListCellViewProtocol {
    var frontView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
