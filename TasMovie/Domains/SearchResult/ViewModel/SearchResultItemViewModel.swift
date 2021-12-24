//
//  SearchResultItemViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class SearchResultItemViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var title: String {
        return model.title
    }
    var overview: String {
        return model.overview
    }
    var imageUrl: String {
        return NetworkConst.ImageUrl.getWSizeImage(size: 500) + model.poster_path
    }
    
    private let model: MovieModel
    
    init(model: MovieModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: SearchResultItemView.className())
        frontViewProperty.cellSize = SearchResultItemView.size(self)
    }
}
