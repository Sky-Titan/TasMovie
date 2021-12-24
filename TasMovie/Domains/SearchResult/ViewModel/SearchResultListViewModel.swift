//
//  SearchResultListViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase
import TasNetwork

class SearchResultListViewModel: BaseListViewModel, SearchDataProvider {
    
    var frontSections: [FrontSection] = []
    weak var requestFinishedDelegate: RequestFinishedDelegate?
    weak var delegate: BaseListViewModelDelegate?
    private var page: Int?
    private var total_pages: Int?
    private var query: String?
    var listHeight: CGFloat {
        return frontSections.listHeight
    }
    private(set) var isRequesting: Bool = false
    
    func resetModel() {
        
    }
    
    func resetModel(model: SearchResultModel) {
        frontSections = []
        makeFrontSection(model: model)
    }
    
    private func makeFrontSection(model: SearchResultModel) {
        let section = FrontSection()
        model.results.forEach { movieModel in
            section.cellViewModels.append(SearchResultItemViewModel(model: movieModel))
            section.cellViewModels.append(ColorDummyViewModel(color: .gray, height: 1))
        }
        frontSections.append(section)
        delegate?.viewModelRefreshed(self)
    }
    
    private func appendItems(model: SearchResultModel) {
        let section = frontSections.last
        model.results.forEach { movieModel in
            section?.cellViewModels.append(SearchResultItemViewModel(model: movieModel))
            section?.cellViewModels.append(ColorDummyViewModel(color: .gray, height: 1))
        }
        delegate?.viewModelRefreshed(self)
    }
    
    func refresh() {
        total_pages = nil
        page = nil
        search(query: "")
    }
    
    func search(query: String) {
        total_pages = nil
        page = nil
        self.query = query
        requestSearchMovie(query: query)
    }
    
    func getNextPage() {
        guard let query = query, let page = page, let total_pages = total_pages, page + 1 < total_pages  else {
            return
        }
        requestSearchMovie(query: query)
    }
    
    func requestSearchMovie(query: String) {
        guard isRequesting == false else { return }
        isRequesting = true
        requestSearchMovie(query: query, language: "ko-KO", page: (page ?? 0) + 1, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.page = response.page
                if strongSelf.total_pages == nil {
                    strongSelf.resetModel(model: response)
                } else {
                    strongSelf.appendItems(model: response)
                }
                strongSelf.total_pages = response.total_pages
                strongSelf.requestFinishedDelegate?.requestSucceed()
            case .failure:
                strongSelf.requestFinishedDelegate?.requestFailed()
            }
            strongSelf.isRequesting = false
        })
    }
}
