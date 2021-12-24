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
    
    public func object<MappingType: BaseJSONMappable>(itemKey: String, objectType: MappingType.Type) -> MappingType? {
        if let dict = self[itemKey] as? [String: Any] {
            return MappingType(from: dict)
        }
        return nil
    }
    
    public func array<MappingType: BaseJSONMappable>(itemKey: String, objectType: MappingType.Type) -> [MappingType] {
        if let array = self[itemKey] as? [[String: Any]] {
            return array.map {
                return MappingType(from: $0)
            }
        }
        return []
    }
    
    public func array<MappingType>(itemKey: String, itemType: MappingType.Type) -> [MappingType] {
        if let arr = self[itemKey] as? [MappingType] {
            return arr
        }
        return []
    }
}
