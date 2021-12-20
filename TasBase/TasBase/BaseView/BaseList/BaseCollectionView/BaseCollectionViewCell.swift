//
//  BaseCollectionViewCell.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

public class BaseCollectionViewCell: UICollectionViewCell, BaseListCellViewProtocol {
    
    var frontView: UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
