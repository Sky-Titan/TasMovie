//
//  AccountDetailModel.swift
//  TasMovie
//
//  Created by 박준현 on 2022/01/01.
//

import Foundation
import TasNetwork

public class AccountDetailModel: BaseJSONMappable {
    let avatar: AvatarModel
    let id: Int
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let include_adult: Bool
    let username: String
    
    public required init(from json: [String : Any]) {
        avatar = json.object(itemKey: "avatar", objectType: AvatarModel.self) ?? AvatarModel()
        id = json.integer(itemKey: "id") ?? 0
        iso_639_1 = json.string(itemKey: "iso_639_1") ?? ""
        iso_3166_1 = json.string(itemKey: "iso_3166_1") ?? ""
        name = json.string(itemKey: "name") ?? ""
        include_adult = json.bool(itemKey: "include_adult") ?? false
        username = json.string(itemKey: "username") ?? ""
    }
}

public class AvatarModel: BaseJSONMappable {
    let gravatar: GravatarModel
    let tmdb: TMDBAvatarModel
    convenience init() {
        self.init(from: [:])
    }
    
    public required init(from json: [String : Any]) {
        gravatar = json.object(itemKey: "gravatar", objectType: GravatarModel.self) ?? GravatarModel()
        tmdb = json.object(itemKey: "tmdb", objectType: TMDBAvatarModel.self) ?? TMDBAvatarModel()
    }
}

public class GravatarModel: BaseJSONMappable {
    
    let hash: String
    convenience init() {
        self.init(from: [:])
    }
    
    public required init(from json: [String : Any]) {
        hash = json.string(itemKey: "hash") ?? ""
    }
}

public class TMDBAvatarModel: BaseJSONMappable {
    let avatar_path: String?
    convenience init() {
        self.init(from: [:])
    }
    
    public required init(from json: [String : Any]) {
        avatar_path = json.string(itemKey: "avatar_path")
    }
}
