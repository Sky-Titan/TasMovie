//
//  SearchResultItemViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class SearchResultItemViewModel: FrontViewModelProtocol, Touchable {
    var touch: (() -> Void)?
    
    func onTouch() {
        let movieVC = MovieDetailViewController()
        movieVC.id = id
        ViewManager.shared.pushViewController(viewController: movieVC, animated: true)
    }
    
    var frontViewProperty: FrontViewProperty
    var id: Int {
        return model.id
    }
    var title: String {
        return model.title
    }
    var overview: String? {
        return model.overview
    }
    var imageUrl: String? {
        guard let poster_path = model.poster_path else { return nil }
        return NetworkConst.ImageUrl.getOriginalImage + poster_path
    }
    
    private let model: MovieSearchModel
    
    init(model: MovieSearchModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: SearchResultItemView.className())
        frontViewProperty.cellSize = SearchResultItemView.size(self)
    }
}
