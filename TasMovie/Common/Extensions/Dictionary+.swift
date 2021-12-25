//
//  Dictionary+.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation
import TasNetwork

extension Dictionary where Key == String, Value == Any {
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
}
