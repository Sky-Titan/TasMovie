//
//  NetworkConst.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation

public class NetworkConst {
    
    static let baseUri = "https://api.themoviedb.org/3"
    static let imageBaseUri = "https://image.tmdb.org/t/p"
    static var API_KEY: String {
        return Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String ?? ""
    }
    
    enum Path {
        static let movie = "/movie"
        static let find = "/find"
        static let search = "/search"
    }
    
    enum SearchUrl {
        static var getSearchMovies: String {
            return baseUri + Path.search + "/movie"
        }
    }
    
    enum ImageUrl {
        static var getOriginalImage: String {
            return imageBaseUri + "/original"
        }
        static func getWSizeImage(size: Int) -> String {
            return imageBaseUri + "/w\(size)"
        }
    }
}
