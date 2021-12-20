//
//  Collection+.swift
//  TasUtility
//
//  Created by 박준현 on 2021/11/29.
//

import UIKit

extension Collection {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
