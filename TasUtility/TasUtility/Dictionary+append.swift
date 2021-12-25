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

extension Dictionary where Key == String, Value == Any {
    public func string(itemKey: String) -> String? {
        return self[itemKey] as? String
    }
    
    public func integer(itemKey: String) -> Int? {
        return self[itemKey] as? Int
    }
    
    public func double(itemKey: String) -> Double? {
        return self[itemKey] as? Double
    }
    
    public func bool(itemKey: String) -> Bool? {
        return self[itemKey] as? Bool
    }
    
    public func array<MappingType>(itemKey: String, itemType: MappingType.Type) -> [MappingType] {
        if let arr = self[itemKey] as? [MappingType] {
            return arr
        }
        return []
    }
}
