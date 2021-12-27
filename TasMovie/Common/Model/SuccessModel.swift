//
//  SuccessModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/27.
//

import Foundation
import TasNetwork

class SuccessModel: BaseJSONMappable {
    let success: Bool
    
    required init(from json: [String : Any]) {
        success = json.bool(itemKey: "success") ?? false
    }
}
