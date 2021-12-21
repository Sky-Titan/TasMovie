//
//  Dictionary+.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation

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
    
    public func object<MappingType: BaseJSONMappable>(itemKey: String, itemType: MappingType.Type) -> MappingType? {
        if let dict = self[itemKey] as? [String: Any] {
            return MappingType(from: dict)
        }
        return nil
    }
}
