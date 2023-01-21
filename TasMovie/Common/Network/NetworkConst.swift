//
//  NetworkConst.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation

public class NetworkConst {
    
    static let scheme = "https"
    static let baseUri = "\(scheme)://api.themoviedb.org/3"
    static let imageBaseUri = "\(scheme)://image.tmdb.org/t/p"
    static var API_KEY: String {
        return Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String ?? ""
    }
    
    private enum Path {
        static let movie = "/movie"
        static let find = "/find"
        static let search = "/search"
        static let authentication = "/authentication"
        static let account = "/account"
    }
    
    enum AccountUrl {
        static var getAccountDetail: String {
            return baseUri + Path.account
        }
    }
    
    enum AuthenticationUrl {
        static var getNewToken: String {
            return baseUri + Path.authentication + "/token/new"
        }
        static var createNewSession: String {
            return baseUri + Path.authentication + "/session/new"
        }
        static var requestValidateWithLogin: String {
            return baseUri + Path.authentication + "/token/validate_with_login"
        }
        static var logout: String {
            return baseUri + Path.authentication + "/session"
        }
    }
    
    enum SearchUrl {
        static var getSearchMovies: String {
            return baseUri + Path.search + "/movie"
        }
    }
    
    enum MovieUrl {
        static func getMovieDetail(id: Int) -> String {
            return baseUri + Path.movie + "/\(id)"
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
