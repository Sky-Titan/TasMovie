//
//  NewSessionModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasNetwork

class NewSessionModel: BaseJSONMappable {
    let success: Bool
    let session_id: String

    required init(from json: [String : Any]) {
        success = json.bool(itemKey: "success") ?? false
        session_id = json.string(itemKey: "session_id") ?? ""
    }
}
