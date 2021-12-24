//
//  MovieDetailPosterViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class MovieDetailPosterViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var imageUrl: String? {
        guard let poster_path = model.poster_path else { return nil }
        return NetworkConst.ImageUrl.getOriginalImage + poster_path
    }
    
    private let model: MovieDetailModel
    
    init(model: MovieDetailModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: MovieDetailPosterView.className())
        frontViewProperty.cellSize = MovieDetailPosterView.size(self)
    }
}
