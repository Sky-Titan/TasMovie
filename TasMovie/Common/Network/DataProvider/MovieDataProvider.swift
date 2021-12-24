//
//  MovieDataProvider.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation
import TasNetwork

protocol MovieDataProvider: DataProvider {
}
extension MovieDataProvider {
    func requestMovieDetail(id: Int, language: String? = "ko", completion: @escaping ((APIResult<MovieDetailModel>) -> Void)) {
        var params: [String: String] = [:]
        if let language = language {
            params["language"] = language
        }
        let api = api.requestAPI(url: NetworkConst.MovieUrl.getMovieDetail(id: id), with: .get, params: params)
        api.send(completion: completion)
    }
}
