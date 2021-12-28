//
//  BaseTableHeaderFooterView.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

class BaseTableHeaderFooterView: UITableViewHeaderFooterView, BaseListCellViewProtocol {
    
    var frontView: UIView?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
