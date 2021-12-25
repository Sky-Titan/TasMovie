//
//  GenreListViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class GenreListViewModel: BaseListViewModel {
    var frontSections: [FrontSection] = []
    
    weak var delegate: BaseListViewModelDelegate?
    
    func resetModel() {
        
    }
    
    func resetModel(models: [GenreModel]) {
        frontSections = []
        makeFrontSections(models: models)
    }
    
    private func makeFrontSections(models: [GenreModel]) {
        let section = FrontSection()
        section.cellViewModels.append(contentsOf: models.map({ model in
            return GenreItemViewModel(model: model)
        }))
        frontSections.append(section)
        delegate?.viewModelRefreshed(self)
    }
    
    
}
