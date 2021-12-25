//
//  MovieDetailGenreIconView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class MovieDetailGenreIconView: BaseXibView, FrontViewProtocol {
    @IBOutlet weak var collectionView: BaseCollectionView!
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? MovieDetailGenreIconViewModel else { return }
        collectionView.viewModel = viewModel.listViewModel
        viewModel.listViewModel.delegate = collectionView
        viewModel.listViewModel.resetModel(models: viewModel.genres)
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? MovieDetailGenreIconViewModel, viewModel.genres.isNotEmpty else { return .zero }
        return CGSize(width: UIScreen.mainWidth, height: 50)
    }
    
    override func nibName() -> String? {
        return "MovieDetailGenreIconView"
    }
}
