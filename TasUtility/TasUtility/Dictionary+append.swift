//
//  Dictionary+.swift
//  TasUtility
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation

extension Dictionary {
    
    mutating public func append(contentsOf list: [Key: Value]) {
        for (k, v) in list {
            self.updateValue(v, forKey: k)
        }
    }
}
