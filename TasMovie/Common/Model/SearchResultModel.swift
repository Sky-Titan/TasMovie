//
//  SearchResultModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation
import TasNetwork

class SearchResultModel: BaseJSONMappable {
    
    let page: Int
    let results: [MovieModel]
    let total_results: Int
    let total_pages: Int
    
    required init(from json: [String : Any]) {
        page = json.integer(itemKey: "page") ?? 0
        results = json.array(itemKey: "results", objectType: MovieModel.self)
        total_results = json.integer(itemKey: "total_results") ?? 0
        total_pages = json.integer(itemKey: "total_pages") ?? 0
    }
}
