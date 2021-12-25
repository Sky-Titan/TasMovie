//
//  MovieDetailGenreIconViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import Foundation
import TasBase

class MovieDetailGenreIconViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var genres: [GenreModel] {
        return model.genres
    }
    let listViewModel = GenreListViewModel()
    
    private let model: MovieDetailModel
    
    init(model: MovieDetailModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: MovieDetailGenreIconView.className())
        frontViewProperty.cellSize = MovieDetailGenreIconView.size(self)
    }
}
