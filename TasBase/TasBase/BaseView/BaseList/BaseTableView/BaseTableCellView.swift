//
//  BaseTableCellView.swift
//  TasBase
//
//  Created by 박준현 on 2021/11/30.
//

import UIKit
import TasUtility

class BaseTableCellView: UITableViewCell, BaseListCellViewProtocol {
    
    var frontView: UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
