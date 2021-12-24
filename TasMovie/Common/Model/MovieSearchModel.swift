//
//  MovieModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/21.
//

import Foundation
import TasNetwork

/*
{
  "poster_path": "/IfB9hy4JH1eH6HEfIgIGORXi5h.jpg",
  "adult": false,
  "overview": "Jack Reacher must uncover the truth behind a major government conspiracy in order to clear his name. On the run as a fugitive from the law, Reacher uncovers a potential secret from his past that could change his life forever.",
  "release_date": "2016-10-19",
  "genre_ids": [
    53,
    28,
    80,
    18,
    9648
  ],
  "id": 343611,
  "original_title": "Jack Reacher: Never Go Back",
  "original_language": "en",
  "title": "Jack Reacher: Never Go Back",
  "backdrop_path": "/4ynQYtSEuU5hyipcGkfD6ncwtwz.jpg",
  "popularity": 26.818468,
  "vote_count": 201,
  "video": false,
  "vote_average": 4.19
}*/

protocol MovieModelProtocol: AnyObject {
    var poster_path: String? { get set }
    var adult: Bool { get set }
    var overview: String? { get set }
    var release_date: String { get set }
    var id: Int { get set }
    var original_title: String { get set }
    var original_language: String { get set }
    var title: String { get set }
    var backdrop_path: String? { get set }
    var popularity: Double { get set }
    var vote_count: Int { get set }
    var video: Bool { get set }
    var vote_average: Double { get set }
}

class MovieSearchModel: MovieModelProtocol, BaseJSONMappable {
    var poster_path: String?
    var overview: String?
    var backdrop_path: String?
    var adult: Bool
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
    
    convenience init() {
        self.init(from: [:])
    }
    
    required init(from json: [String : Any]) {
        poster_path = json.string(itemKey: "poster_path")
        adult = json.bool(itemKey: "adult") ?? false
        overview = json.string(itemKey: "overview")
        release_date = json.string(itemKey: "release_date") ?? ""
        genre_ids = json.array(itemKey: "genre_ids", itemType: Int.self)
        id = json.integer(itemKey: "id") ?? 0
        original_title = json.string(itemKey: "original_title") ?? ""
        original_language = json.string(itemKey: "original_language") ?? ""
        title = json.string(itemKey: "title") ?? ""
        backdrop_path = json.string(itemKey: "backdrop_path")
        popularity = json.double(itemKey: "popularity") ?? 0
        vote_count = json.integer(itemKey: "vote_count") ?? 0
        video = json.bool(itemKey: "video") ?? false
        vote_average = json.double(itemKey: "vote_average") ?? 0
    }
}

/*
{
    "adult": false,
    "backdrop_path": "/sWvxBXNtCOaGdtpKNLiOqmwb10N.jpg",
    "belongs_to_collection": {
        "id": 556,
        "name": "Spider-Man Collection",
        "poster_path": "/bp5PqLa06QA1LsELA1SsKZ008H7.jpg",
        "backdrop_path": "/waZqriYTuBE3WqXI3SDGi3kfDQE.jpg"
    },
    "budget": 139000000,
    "genres": [{
        "id": 14,
        "name": "Fantasy"
    }, {
        "id": 28,
        "name": "Action"
    }],
    "homepage": "http://www.sonypictures.com/movies/spider-man/",
    "id": 557,
    "imdb_id": "tt0145487",
    "original_language": "en",
    "original_title": "Spider-Man",
    "overview": "After being bitten by a genetically altered spider at Oscorp, nerdy but endearing high school student Peter Parker is endowed with amazing powers to become the superhero known as Spider-Man.",
    "popularity": 1957.522,
    "poster_path": "/gSZyYEK5AfZuOFFjnVPUCLvdOD6.jpg",
    "production_companies": [{
        "id": 19551,
        "logo_path": "/2WpWp9b108hizjHKdA107hFmvQ5.png",
        "name": "Marvel Enterprises",
        "origin_country": "US"
    }, {
        "id": 5,
        "logo_path": "/71BqEFAF4V3qjjMPCpLuyJFB9A.png",
        "name": "Columbia Pictures",
        "origin_country": "US"
    }, {
        "id": 34,
        "logo_path": "/GagSvqWlyPdkFHMfQ3pNq6ix9P.png",
        "name": "Sony Pictures",
        "origin_country": "US"
    }, {
        "id": 326,
        "logo_path": null,
        "name": "Laura Ziskin Productions",
        "origin_country": ""
    }, {
        "id": 7505,
        "logo_path": "/837VMM4wOkODc1idNxGT0KQJlej.png",
        "name": "Marvel Entertainment",
        "origin_country": "US"
    }],
    "production_countries": [{
        "iso_3166_1": "US",
        "name": "United States of America"
    }],
    "release_date": "2002-05-01",
    "revenue": 821708551,
    "runtime": 121,
    "spoken_languages": [{
        "english_name": "English",
        "iso_639_1": "en",
        "name": "English"
    }],
    "status": "Released",
    "tagline": "Go for the ultimate spin.",
    "title": "Spider-Man",
    "video": false,
    "vote_average": 7.2,
    "vote_count": 14750
}
*/

class MovieDetailModel: MovieModelProtocol, BaseJSONMappable {
    var poster_path: String?
    var overview: String?
    var production_countries: [CountryModel]
    var production_companies: [CompanyModel]
    var belongs_to_collection: CollectionModel
    var adult: Bool
    var release_date: String
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
    var homepage: String
    var genres: [GenreModel]
    var tagline: String?
    var status: MovieStatus
    var runtime: Int?
    var revenue: Int
    var budget: Int
    var imdb_id: String?
    
    required init(from json: [String : Any]) {
        imdb_id = json.string(itemKey: "imdb_id")
        poster_path = json.string(itemKey: "poster_path")
        adult = json.bool(itemKey: "adult") ?? false
        overview = json.string(itemKey: "overview")
        release_date = json.string(itemKey: "release_date") ?? ""
        genres = json.array(itemKey: "genres", objectType: GenreModel.self)
        id = json.integer(itemKey: "id") ?? 0
        original_title = json.string(itemKey: "original_title") ?? ""
        original_language = json.string(itemKey: "original_language") ?? ""
        title = json.string(itemKey: "title") ?? ""
        backdrop_path = json.string(itemKey: "backdrop_path")
        popularity = json.double(itemKey: "popularity") ?? 0
        vote_count = json.integer(itemKey: "vote_count") ?? 0
        video = json.bool(itemKey: "video") ?? false
        vote_average = json.double(itemKey: "vote_average") ?? 0
        production_companies = json.array(itemKey: "production_companies", objectType: CompanyModel.self)
        production_countries = json.array(itemKey: "production_countries", objectType: CountryModel.self)
        belongs_to_collection = json.object(itemKey: "belongs_to_collection", objectType: CollectionModel.self) ?? CollectionModel()
        status = MovieStatus(rawValue: json.string(itemKey: "status") ?? "") ?? .Rumored
        homepage = json.string(itemKey: "homepage") ?? ""
        tagline = json.string(itemKey: "tagline")
        runtime = json.integer(itemKey: "runtime")
        revenue = json.integer(itemKey: "revenue") ?? 0
        budget = json.integer(itemKey: "budget") ?? 0
    }
    
    
}

enum MovieStatus: String  {
    case Rumored
    case Planned
    case In_Production = "In Production"
    case Post_Production = "Post Production"
    case Released
    case Canceled
}

class CollectionModel: BaseJSONMappable {
    let id: Int
    let name: String
    let poster_path: String
    let backdrop_path: String
    
    convenience init() {
        self.init(from: [:])
    }
    
    required init(from json: [String : Any]) {
        id = json.integer(itemKey: "id") ?? 0
        name = json.string(itemKey: "name") ?? ""
        poster_path = json.string(itemKey: "poster_path") ?? ""
        backdrop_path = json.string(itemKey: "backdrop_path") ?? ""
    }
}

class CompanyModel: BaseJSONMappable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
    
    required init(from json: [String : Any]) {
        id = json.integer(itemKey: "id") ?? 0
        logo_path = json.string(itemKey: "logo_path")
        name = json.string(itemKey: "name") ?? ""
        origin_country = json.string(itemKey: "origin_country") ?? ""
    }
}

class CountryModel: BaseJSONMappable {
    let iso_3166_1: String
    let name: String
    
    required init(from json: [String : Any]) {
        iso_3166_1 = json.string(itemKey: "iso_3166_1") ?? ""
        name = json.string(itemKey: "name") ?? ""
    }
}

class GenreModel: BaseJSONMappable {
    
    let id: Int
    let name: String
    
    required init(from json: [String : Any]) {
        id = json.integer(itemKey: "id") ?? 0
        name = json.string(itemKey: "name") ?? ""
    }
}
