//
//  MovieDetailListViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase
import TasNetwork

class MovieDetailListViewModel: BaseListViewModel, MovieDataProvider {
    var frontSections: [FrontSection] = []
    weak var delegate: BaseListViewModelDelegate?
    weak var requestFinishedDelegate: RequestFinishedDelegate?

    var title: String?
    var id: Int?
    
    func resetModel() {
        frontSections = []
        requestMovieDetail()
    }
    
    private func makeFrontSection(model: MovieDetailModel) {
        let section = FrontSection()
        section.cellViewModels.append(MovieDetailPosterViewModel(model: model))
        section.cellViewModels.append(MovieDetailGenreIconViewModel(model: model))
        section.cellViewModels.append(MovieDetailDescriptionViewModel(model: model))
        frontSections.append(section)
        delegate?.viewModelRefreshed(self)
    }
    
    private func requestMovieDetail() {
        guard let id = id else { return }
        requestMovieDetail(id: id, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.title = response.title
                strongSelf.requestFinishedDelegate?.requestSucceed()
                strongSelf.makeFrontSection(model: response)
            case .failure:
                strongSelf.requestFinishedDelegate?.requestFailed()
            }
        })
    }
}
