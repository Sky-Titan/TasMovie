//
//  NewTokenModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasNetwork

class NewTokenModel: BaseJSONMappable {
    let success: Bool
    let expires_at: String
    let request_token: String

    required init(from json: [String : Any]) {
        success = json.bool(itemKey: "success") ?? false
        expires_at = json.string(itemKey: "expires_at") ?? ""
        request_token = json.string(itemKey: "request_token") ?? ""
    }
}
