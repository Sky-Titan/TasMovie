//
//  MovieDetailDescriptionViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class MovieDetailDescriptionViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var overview: String? {
        return model.overview
    }
    var popularity: Double {
        return model.popularity
    }
    var production_countries: [CountryModel] {
        return model.production_countries
    }
    var production_companies: [CompanyModel] {
        return model.production_companies
    }
    var genres: [GenreModel] {
        return model.genres
    }
    var status: MovieStatus {
        return model.status
    }
    var homepage: String {
        return model.homepage
    }
    var adult: Bool {
        return model.adult
    }
    var release_date: String {
        return model.release_date
    }
    var vote_count: Int {
        return model.vote_count
    }
    var vote_average: Double {
        return model.vote_average
    }
    var runtime: Int? {
        return model.runtime
    }
    
    private let model: MovieDetailModel
    
    init(model: MovieDetailModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: MovieDetailDescriptionView.className())
        frontViewProperty.cellSize = MovieDetailDescriptionView.size(self)
    }
}
