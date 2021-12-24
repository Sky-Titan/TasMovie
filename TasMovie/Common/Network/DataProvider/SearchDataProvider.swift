//
//  SearchDataProvider.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation
import TasNetwork

protocol SearchDataProvider: DataProvider {

}

extension SearchDataProvider {
    func requestSearchMovie(query: String, language: String? = "ko", page: Int? = nil, include_adult: Bool? = nil, region: String? = nil, year: Int? = nil, primary_release_year: Int? = nil, completion: @escaping(APIResult<SearchResultModel>) -> Void) {
        var params: [String: String] = [:]
        params["query"] = query
        if let language = language {
            params["language"] = language
        }
        if let page = page {
            params["page"] = page.description
        }
        if let include_adult = include_adult {
            params["include_adult"] = include_adult.description
        }
        if let region = region {
            params["region"] = region
        }
        if let year = year {
            params["year"] = year.description
        }
        if let primary_release_year = primary_release_year {
            params["primary_release_year"] = primary_release_year.description
        }
        let api = api.requestAPI(url: NetworkConst.SearchUrl.getSearchMovies, with: .get, params: params)
        
        api.send(completion: completion)
    }
}
